package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_1541 extends BaseMapProcess
   {
      
      private var flowerMc:MovieClip;
      
      public function MapProcess_1541()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel.addEventListener(MouseEvent.CLICK,this.onClick);
         this.flowerMc = conLevel["flower_anim"];
         this.flowerMc.addFrameScript(58,function():void
         {
            flowerMc.gotoAndStop(1);
            flowerMc.visible = false;
            conLevel["flower_btn"].visible = true;
         });
         this.flowerMc.gotoAndStop(1);
         this.flowerMc.visible = false;
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "flower_btn":
               conLevel["flower_btn"].visible = false;
               this.flowerMc.visible = true;
               this.flowerMc.gotoAndPlay(1);
         }
      }
      
      override public function destroy() : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.destroy();
      }
   }
}

