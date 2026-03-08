package com.robot.app.mapProcess
{
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_11920 extends BaseMapProcess
   {
      
      public function MapProcess_11920()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.btnLevel["mainPetBtn"].addEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      protected function onMouseClick(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("SiJiuHuanXi_BackPanel");
      }
      
      override public function destroy() : void
      {
         this.btnLevel["mainPetBtn"].removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         super.destroy();
      }
   }
}

