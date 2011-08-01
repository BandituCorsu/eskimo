package com.pialabs.eskimo.components
{
  import com.pialabs.eskimo.data.SectionTitleLabel;
  
  import flash.events.MouseEvent;
  
  import mx.core.ClassFactory;
  import mx.core.IVisualElement;
  
  import spark.components.IItemRenderer;
  import spark.components.List;
  import spark.layouts.VerticalLayout;
  
  /**
   *  Dispatched after the selection has changed.
   *  This event is dispatched when the user interacts with the control.
   */
  [Event(name = "change", type = "spark.events.IndexChangeEvent")]
  
  /**
   * Defines the section background color
   *
   * @default #C0C0C0
   */
  [Style(name = "sectionBackgroundColor", inherit = "no", type = "uint")]
  
  /**
   * Defines the section title color
   *
   * @default #C0C0C0
   */
  [Style(name = "sectionTitleColor", inherit = "no", type = "uint")]
  
  /**
   *  The horizontal alignment of the title.
   *
   *  Possible values are <code>"left"</code>, <code>"center"</code>,
   *  and <code>"right"</code>.
   *
   *  @default "left"
   */
  [Style(name = "sectionTitleAlign", type = "String", enumeration = "left,center,right", inherit = "no")]
  
  /**
   *  The height of section title.
   */
  [Style(name = "sectionHeight", type = "int", inherit = "no")]
  
  /**
   * List that contains some section to order item.
   * @see com.pialabs.eskimo.components.SectionItemRenderer
   * @see com.pialabs.eskimo.data.SectionTitleLabel
   */
  public class SectionList extends List
  {
    public function SectionList()
    {
      super();
      itemRenderer = new ClassFactory(SectionItemRenderer);
      var sectionLayout:VerticalLayout = new VerticalLayout();
      sectionLayout.variableRowHeight = true;
      sectionLayout.gap = 0;
      sectionLayout.horizontalAlign = "contentJustify";
      this.layout = sectionLayout;
    }
    
    override protected function item_mouseDownHandler(event:MouseEvent):void
    {
      var data:Object;
      if (event.currentTarget is IItemRenderer)
      {
        data = IItemRenderer(event.currentTarget).data;
      }
      
      if (data is SectionTitleLabel)
      {
        event.preventDefault();
      }
      super.item_mouseDownHandler(event);
    }
    
    override public function updateRenderer(renderer:IVisualElement, itemIndex:int, data:Object):void
    {
      if (renderer is SectionItemRenderer)
      {
        
        var sectionRenderer:SectionItemRenderer = renderer as SectionItemRenderer;
        var sectionTitleColor:uint = 0x000000;
        var sectionHeight:int = 45;
        var sectionTitleAlign:String = "left";
        
        if (data is SectionTitleLabel)
        {
          var secTitleColor:uint = getStyle("sectionTitleColor");
          if (secTitleColor > 0)
          {
            sectionTitleColor = secTitleColor;
          }
          
          var secHeight:int = getStyle("sectionHeight");
          if (secHeight > 0)
          {
            sectionHeight = secHeight;
          }
          var secTitleAlign:String = getStyle("sectionTitleAlign");
          if (secTitleAlign)
          {
            sectionTitleAlign = secTitleAlign;
          }
        }
        sectionRenderer.sectionHeight = sectionHeight;
        sectionRenderer.sectionTitleColor = sectionTitleColor;
        sectionRenderer.sectionTitleAlign = sectionTitleAlign;
        
        sectionRenderer.invalidateSize();
      }
      super.updateRenderer(renderer, itemIndex, data);
    }
  }
}