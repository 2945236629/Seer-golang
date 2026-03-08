package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import org.taomee.events.SocketEvent;
   
   public class MapProcess_11060 extends BaseMapProcess
   {
      
      public function MapProcess_11060()
      {
         super();
      }
      
      override public function setup() : void
      {
         super.setup();
         getDefinitionByName("com.robot.app2.control.PeakJihadController").initMap1095(this);
         getDefinitionByName("com.robot.app2.control.PeakJihad2016Controller").setup(this);
         SocketConnection.addCmdListener(45141,this.onMatchNotificationPacket);
      }
      
      private function onMatchNotificationPacket(param1:SocketEvent) : void
      {
         var mode:int;
         var rivalUserID:int;
         var score:int;
         var e:SocketEvent = param1;
         var b:ByteArray = e.data as ByteArray;
         b.position = 0;
         mode = int(b.readUnsignedInt());
         rivalUserID = int(b.readUnsignedInt());
         score = int(b.readUnsignedInt());
         SocketConnection.removeCmdListener(45141,arguments.callee);
         KTool.getMultiValue([3306],function(param1:Array):void
         {
            if(param1[0] == 1)
            {
               ModuleManager.showModule(ClientConfig.getAppModule("PeakJihad3V32016RevisionPanel"),"正在打开....");
            }
            else if(param1[0] == 2)
            {
               ModuleManager.showModule(ClientConfig.getAppModule("PeakJihad6V62016RevisionPanel"),"正在打开....");
            }
         });
      }
      
      override public function destroy() : void
      {
         super.destroy();
         getDefinitionByName("com.robot.app2.control.PeakJihadController").destroy();
         getDefinitionByName("com.robot.app2.control.PeakJihad2016Controller").destroy();
         SocketConnection.removeCmdListener(45141,this.onMatchNotificationPacket);
      }
   }
}

