package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.control.TrainDoorController;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alert;
   
   public class MapProcess_10083 extends BaseMapProcess
   {
      
      public function MapProcess_10083()
      {
         super();
      }
      
      override protected function init() : void
      {
         TrainDoorController.getInstance().initWaitRoom(this);
      }
      
      override public function destroy() : void
      {
         TrainDoorController.getInstance().destroyWaitRoom();
      }
      
      public function onLeaveMap() : void
      {
         Alert.show("是否要离开训练之门？中途离开的话，再次进入需要从头开始挑战哦！",function():void
         {
            TrainDoorController.getInstance().leaveGame();
         });
      }
      
      public function onEnterMap() : void
      {
         TrainDoorController.getInstance()._curtLayer = 1;
         TrainDoorController.getInstance()._curtGameTpye = 1;
         MapManager.changeLocalMap(10084);
      }
   }
}

