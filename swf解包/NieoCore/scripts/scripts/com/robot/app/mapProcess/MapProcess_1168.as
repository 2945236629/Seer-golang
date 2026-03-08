package com.robot.app.mapProcess
{
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_1168 extends BaseMapProcess
   {
      
      public function MapProcess_1168()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         btnLevel.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target.name == "btn_1" || param1.target.name == "btn_2")
         {
            ModuleManager.showAppModule("DragonFateStep2Panel");
         }
      }
      
      override public function destroy() : void
      {
         btnLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.destroy();
      }
   }
}

