package com.pialabs.eskimo.components
{
  import flash.events.Event;
  
  import mx.collections.ArrayCollection;
  import mx.core.mx_internal;
  
  import spark.components.ButtonBar;
  import spark.components.Group;
  import spark.components.Label;
  import spark.components.ViewNavigator;
  import spark.components.supportClasses.SkinnableComponent;
  import spark.components.supportClasses.ViewDescriptor;
  import spark.events.IndexChangeEvent;
  import spark.utils.LabelUtil;
  
  use namespace mx_internal;
  
  /**
  * BreadCrumb trail componenet.
  * You need to specify a ViewNavigator, then the BreadCrumb automaticaly update his elements.
  * Button labels are populated with the labelField of the View's data property
  */
  public class BreadCrumb extends ButtonBar
  {
    /**
    * @private
    */
    protected var _viewNavigator:ViewNavigator;
    
    /**
     * @private
     */
    public function BreadCrumb()
    {
      super();
      
      this.addEventListener(IndexChangeEvent.CHANGE, onIndexChange, false, 0, true);
    }
    
    /**
     * @private
     */
    override protected function commitProperties():void
    {
      super.commitProperties();
      
      if (!viewNavigator)
      {
        throw new Error("BreadCrumb need viewnavigator property to be set");
      }
      
      var breadCrumbLength:int = _viewNavigator.navigationStack.length;
      
      var viewDescriptor:ViewDescriptor;
      var labelDisplay:Label;
      var i:int;
      
      if (dataProvider == null)
      {
        dataProvider = new ArrayCollection();
      }
      
      
      var diff:int = Math.abs(breadCrumbLength - dataProvider.length);
      if (breadCrumbLength < dataProvider.length)
      {
        while (diff > 0)
        {
          dataProvider.removeItemAt(dataProvider.length - 1);
          diff--;
        }
      }
      else if (breadCrumbLength > dataProvider.length)
      {
        for (i = dataProvider.length; i < breadCrumbLength; i++)
        {
          viewDescriptor = _viewNavigator.navigationStack.source[i];
          
          dataProvider.addItem(viewDescriptor.data);
        }
      }
      
      selectedIndex = breadCrumbLength - 1;
    }
    
    /**
     * @private
     */
    protected function onIndexChange(event:IndexChangeEvent):void
    {
      if (event.newIndex == -1)
      {
        return;
      }
      
      var breadCrumbLength:int = _viewNavigator.navigationStack.length;
      var numberToPop:int = breadCrumbLength - event.newIndex;
      
      while (numberToPop > 1)
      {
        _viewNavigator.popView();
        numberToPop--;
      }
      
      itemSelected(event.newIndex, false);
    }
    
    /**
     * @private
     */
    protected function onViewChangeComplete(event:Event):void
    {
      invalidateProperties();
    }
    
    /**
     * View nafigator watched by the BreadCrumb component
     */
    public function get viewNavigator():ViewNavigator
    {
      return _viewNavigator;
    }
    
    /**
     * @private
     */
    public function set viewNavigator(value:ViewNavigator):void
    {
      dataProvider = null;
      
      _viewNavigator = value;
      
      _viewNavigator.addEventListener("viewChangeComplete", onViewChangeComplete, false, 0, true);
    }
  
  
  }
}
