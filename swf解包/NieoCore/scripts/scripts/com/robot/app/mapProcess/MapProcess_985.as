package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.utils.RectangleMask;
   import flash.events.MouseEvent;
   import org.taomee.events.DynamicEvent;
   
   public class MapProcess_985 extends BaseMapProcess
   {
      
      public function MapProcess_985()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
         MapListenerManager.add(conLevel["braveBtn1"],this.onClick1,"经验大作战");
         MapListenerManager.add(conLevel["braveBtn2"],this.onClick2,"学习力大作战");
      }
      
      private function onClick1(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("ADBraveChallengeExpStudyPanel"),"",1);
      }
      
      private function onClick2(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("ADBraveChallengeExpStudyPanel"),"",2);
         RectangleMask.dispatchEvent(new DynamicEvent(RectangleMask.CLICK_NEXT,410));
      }
      
      override public function destroy() : void
      {
      }
   }
}

