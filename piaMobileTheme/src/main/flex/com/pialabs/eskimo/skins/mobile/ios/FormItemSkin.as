package com.pialabs.eskimo.skins.mobile.ios
{
  import flash.events.Event;
  
  import mx.containers.utilityClasses.ConstraintColumn;
  import mx.containers.utilityClasses.ConstraintRow;
  import mx.events.FlexEvent;
  import mx.states.State;
  
  import spark.components.FormItem;
  import spark.components.Group;
  import spark.components.Label;
  import spark.components.supportClasses.Skin;
  import spark.layouts.FormItemLayout;
  import spark.layouts.VerticalLayout;
  
  /**
   * @copy spark.skins.spark.ApplicationSkin#hostComponent
   */
  [HostComponent("spark.components.FormItem")]
  
  [States("normal", "disabled", "error", "required", "requiredAndDisabled", "requiredAndError")]
  
  public class FormItemSkin extends Skin
  {
    public var labelDisplay:Label;
    public var contentGroup:Group;
    
    public var sequenceCol:ConstraintColumn;
    public var labelCol:ConstraintColumn;
    public var contentCol:ConstraintColumn;
    public var helpCol:ConstraintColumn;
    
    [Bindable]
    public var hostComponent:FormItem;
    
    public function FormItemSkin()
    {
      super();
      
      states = [new State({name: "normal"}), new State({name: "disabled"}), new State({name: "error"})
                           , new State({name: "required"}), new State({name: "requiredAndDisabled"})
                           , new State({name: "requiredAndError"})];
      
      
      var formItemLayout:FormItemLayout = new FormItemLayout();
      var constraintColumns:Vector.<ConstraintColumn> = new Vector.<ConstraintColumn>();
      
      sequenceCol = new ConstraintColumn();
      sequenceCol.width = 0;
      sequenceCol.initialized(this, "sequenceCol");
      constraintColumns.push(sequenceCol);
      
      labelCol = new ConstraintColumn();
      /*labelCol.percentWidth = 100;*/
      labelCol.initialized(this, "labelCol");
      constraintColumns.push(labelCol);
      
      contentCol = new ConstraintColumn();
      contentCol.id = "contentCol";
      contentCol.percentWidth = 100;
      contentCol.initialized(this, "contentCol");
      constraintColumns.push(contentCol);
      
      helpCol = new ConstraintColumn();
      helpCol.id = "helpCol";
      helpCol.maxWidth = 200;
      helpCol.initialized(this, "helpCol");
      constraintColumns.push(helpCol);
      
      formItemLayout.constraintColumns = constraintColumns;
      
      var constraintRows:Vector.<ConstraintRow> = new Vector.<ConstraintRow>();
      
      var constraintRow:ConstraintRow;
      
      constraintRow = new ConstraintRow();
      constraintRow.percentHeight = 100;
      constraintRow.initialized(this, "row1");
      constraintRows.push(constraintRow);
      
      formItemLayout.constraintRows = constraintRows;
      
      layout = formItemLayout;
      
      addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete, false, 0, true);
    }
    
    private function onCreationComplete(event:Event):void
    {
      invalidateDisplayList();
    }
    
    override protected function createChildren():void
    {
      super.createChildren();
      
      if (!labelDisplay)
      {
        labelDisplay = new Label();
        
        labelDisplay.setStyle("verticalAlign", "middle");
        labelDisplay.setStyle("fontWeight", "bold");
        labelDisplay.setStyle("color", 0x000000);
        labelDisplay.top = "row1:4";
        labelDisplay.bottom = "row1:4";
        labelDisplay.left = "labelCol:0";
        labelDisplay.right = "labelCol:5";
        labelDisplay.baseline = "row1:4";
        
        addElementAt(labelDisplay, 0);
          // labelDisplay.percentWidth = 100;
      }
      if (!contentGroup)
      {
        contentGroup = new Group();
        
        contentGroup.setStyle("showErrorTip", false);
        contentGroup.setStyle("showErrorSkin", true);
        
        contentGroup.left = "contentCol:0";
        contentGroup.right = "contentCol:1";
        contentGroup.top = "row1:4";
        contentGroup.bottom = "row1:4";
        
        var vlayout:VerticalLayout = new VerticalLayout();
        vlayout.horizontalAlign = "justify";
        vlayout.verticalAlign = "middle";
        
        contentGroup.layout = vlayout;
        addElement(contentGroup);
      }
    }
    
    
    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
    {
      super.updateDisplayList(unscaledWidth, unscaledHeight);
    }
    
    /**
     *  @private
     */
    override protected function measure():void
    {
      super.measure();
      
      measuredMinHeight = 38;
    }
    
    /**
     *  @private
     */
    override public function setCurrentState(stateName:String, playTransition:Boolean = true):void
    {
      super.setCurrentState(stateName, playTransition);
      invalidateDisplayList();
    }
  
  }
}
