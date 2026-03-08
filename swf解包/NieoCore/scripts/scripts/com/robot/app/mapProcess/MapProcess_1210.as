package com.robot.app.mapProcess
{
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_1210 extends BaseMapProcess
   {
      
      public function MapProcess_1210()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["mc"].buttonMode = true;
         conLevel["mc"].addEventListener(MouseEvent.CLICK,this.onMcClick);
      }
      
      protected function onMcClick(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("DownSecretForbiddenMainPanel");
      }
      
      override public function destroy() : void
      {
         conLevel["mc"].removeEventListener(MouseEvent.CLICK,this.onMcClick);
      }
   }
}

