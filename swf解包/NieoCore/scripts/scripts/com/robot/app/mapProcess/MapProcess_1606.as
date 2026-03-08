package com.robot.app.mapProcess
{
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_1606 extends BaseMapProcess
   {
      
      public function MapProcess_1606()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel.addEventListener(MouseEvent.CLICK,this.onClick);
         conLevel["effect"].mouseEnabled = false;
         conLevel["effect"].mouseChildren = false;
         conLevel["anim"].gotoAndStop(1);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "btn":
               AnimateManager.playMcAnimate(conLevel["anim"]);
         }
      }
      
      override public function destroy() : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.destroy();
      }
   }
}

