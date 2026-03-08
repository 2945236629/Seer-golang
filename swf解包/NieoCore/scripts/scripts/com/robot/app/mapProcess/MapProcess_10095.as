package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.control.TrainDoorController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alert;
   
   public class MapProcess_10095 extends BaseMapProcess
   {
      
      public function MapProcess_10095()
      {
         super();
      }
      
      override protected function init() : void
      {
         TrainDoorController.getInstance().init(this);
      }
      
      override public function destroy() : void
      {
         TrainDoorController.getInstance().destroy();
      }
      
      public function onLeaveMap() : void
      {
         Alert.show("是否要离开训练之门？中途离开的话，再次进入需要从头开始挑战哦！",function():void
         {
            TrainDoorController.getInstance().leaveGame();
         });
      }
   }
}

