package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.InteractiveObject;
   
   public class MapProcess_813 extends BaseMapProcess
   {
      
      public function MapProcess_813()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
         MapListenerManager.add(depthLevel["exchange"] as InteractiveObject,this.onExchangeBtnClick,"兑换装置");
         MapListenerManager.add(depthLevel["infor"] as InteractiveObject,this.onInforBtnClick,"活动详情");
         MapListenerManager.add(depthLevel["evolution"] as InteractiveObject,this.onEvolutionBtn,"超进化装置");
      }
      
      override public function destroy() : void
      {
      }
      
      private function onExchangeBtnClick(param1:*) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("StarPetRingExchangePanel"));
      }
      
      private function onInforBtnClick(param1:*) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("StarPetRingInforPanel"));
      }
      
      private function onEvolutionBtn(param1:*) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("StarPetEvolutionPanel"));
      }
   }
}

