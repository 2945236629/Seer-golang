package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.PetPhantomInDevilCityController;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   
   public class MapProcess_776 extends BaseMapProcess
   {
      
      public function MapProcess_776()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86050034);
         if(PetPhantomInDevilCityController.isActive)
         {
            MapListenerManager.add(conLevel["edison"],this.onExchangeClick,"兑换装置");
         }
         else
         {
            conLevel["act"].visible = false;
            conLevel["edison"].visible = false;
         }
         PetPhantomInDevilCityController.setup(this);
      }
      
      private function onExchangeClick(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86050033);
         ModuleManager.showModule(ClientConfig.getAppModule("PetPhantomInDevilCityExchangePanel"),"正在加载...");
      }
      
      override public function destroy() : void
      {
         PetPhantomInDevilCityController.destroy();
      }
   }
}

