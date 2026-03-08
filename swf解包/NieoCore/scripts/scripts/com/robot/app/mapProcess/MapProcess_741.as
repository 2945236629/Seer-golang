package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1123;
   import com.robot.app.task.taskscollection.Task1370;
   import com.robot.core.CommandID;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import org.taomee.events.SocketEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_741 extends BaseMapProcess
   {
      
      public function MapProcess_741()
      {
         super();
      }
      
      private static function onGetPetClick(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("LeiyiMaiersiPanel"),"正在打开....");
      }
      
      private static function onAd(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("Shengling3rdAdPanel"),"正在打开....");
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86054400);
         SocketConnection.send(1022,86053223);
         MapListenerManager.add(conLevel["ad"],onAd,"三探圣灵峰，精灵友谊存储器");
         Task1123.initTaskFor741(this);
         Task1370.initForMap741(this);
         SocketConnection.addCmdListener(CommandID.PICTURE_CAPSULE_INFO,function(param1:SocketEvent):void
         {
            SocketConnection.removeCmdListener(CommandID.PICTURE_CAPSULE_INFO,arguments.callee);
            var _loc3_:ByteArray = param1.data as ByteArray;
            _loc3_.readUnsignedInt();
            var _loc4_:uint = _loc3_.readUnsignedInt();
            if(_loc4_ == 0 && SystemTimerManager.time > SystemTimerManager.getTimeByDate(2012,9,6,0))
            {
               DisplayUtil.removeForParent(depthLevel["oldMachine"]);
            }
         });
         SocketConnection.send(CommandID.PICTURE_CAPSULE_INFO);
      }
      
      override public function destroy() : void
      {
         Task1123.destroy();
         Task1370.destroy();
      }
   }
}

