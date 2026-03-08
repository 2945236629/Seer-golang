package com.robot.app.mapProcess
{
   import com.robot.app.control.*;
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import flash.events.MouseEvent;
   
   public class MapProcess_964 extends BaseMapProcess
   {
      
      private var cls:*;
      
      private var cls3:*;
      
      public function MapProcess_964()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86065339);
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         MapListenerManager.add(depthLevel["zhumaBtn"],this.onZhuMaGame);
      }
      
      protected function onLianlianGame(param1:MouseEvent) : void
      {
         GameStartController.show("PetLLKStart","PetLLKGame",true,7);
      }
      
      protected function onShiMenGame(param1:MouseEvent) : void
      {
         GameStartController.show("StoneLLKStart","StoneLLKGame",true,6);
      }
      
      protected function onBingGuanGame(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getGameModule("PetSkateGame"),"正在加载游戏");
      }
      
      private function onPanGaoGame(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86065601);
         PetCarnivalController.getInstance().showRules(PetCarnivalController.JUMP,[false,false,true,false,false]);
      }
      
      private function onZhuMaGame(param1:MouseEvent) : void
      {
         GameStartController.show("ZumaStart2","ZumaGame",true,3);
         SocketConnection.send(1022,86065603);
      }
      
      private function onXingjiGame(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86065602);
         GameStartController.show("XingjiPanPaPanel","FlyeavesgowallGame",true,4);
      }
      
      private function onGift(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86065342);
         ModuleManager.showModule(ClientConfig.getAppModule("adown/WinterGamesGuidePanel"));
      }
      
      private function onHitGame(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86065343);
         ModuleManager.showModule(ClientConfig.getAppModule("RescueFengHuangSonPanel2"));
      }
      
      private function onMouseHurd(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86065345);
         PetCarnivalController.getInstance().showRules(PetCarnivalController.HURDLES,[false,false,false,false,true]);
      }
      
      private function onShadowTrigger(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86065344);
         GameStartController.show("ShadowStart","ShadowGame");
      }
      
      override public function destroy() : void
      {
      }
   }
}

