package com.piaction.skins.mobile.ios
{
    
    import flash.events.Event;
    
    import spark.components.Button;
    import spark.skins.mobile.HSliderSkin;
    
    /**
     * The IOS skin class for the Spark HSlider component.
     *
     *  @see spark.components.HSlider
     */
    public class HSliderSkin extends spark.skins.mobile.HSliderSkin
    {
        /**
         * @private
         */
        protected var coloredTrackSkinClass:Class;
        /**
         * Component for the colored track
         */
        protected var coloredTrack:Button;
        
        /**
         * Constructor
         */
        public function HSliderSkin()
        {
            super();
            
            thumbSkinClass = HSliderThumbSkin;
            trackSkinClass = HSliderTrackSkin;
            coloredTrackSkinClass = HSliderTrackSkin;
        }
        
        
        /**
         *  @private
         */
        override protected function createChildren():void
        {
            super.createChildren();
            
            // Create our skin parts: track and thumb
            coloredTrack = new Button();
            coloredTrack.setStyle("skinClass", coloredTrackSkinClass);
            addChildAt(coloredTrack, 1);
            
            hostComponent.addEventListener(Event.CHANGE, onChange, false, 0, true);
        }
        
        /**
         * @private
         */
        protected function onChange(event:Event):void
        {
            invalidateDisplayList();
        }
        
        /**
         * @private
         */
        override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.layoutContents(unscaledWidth, unscaledHeight);
            
            track.setStyle("chromeColor", 0xf8f8f8);
            coloredTrack.setStyle("chromeColor", getStyle("chromeColor"));
            
            // minimum height is no smaller than the larger of the thumb or track
            var calculatedSkinHeight:int = Math.max(Math.max(thumb.getPreferredBoundsHeight(), track.getPreferredBoundsHeight()), unscaledHeight);
            
            // minimum width is no smaller than the thumb
            var calculatedSkinWidth:int = Math.max(thumb.getPreferredBoundsWidth(), unscaledWidth);
            
            var calculatedTrackY:int = Math.max(Math.round((calculatedSkinHeight - track.getPreferredBoundsHeight()) / 2), 0);
            
            var calculatedTrackX:int = thumb.x + thumb.width / 2;
            
            setElementSize(coloredTrack, calculatedTrackX, track.getPreferredBoundsHeight()); // note track is NOT scaled vertically
            setElementPosition(coloredTrack, 0, calculatedTrackY);
        }
    }
}
