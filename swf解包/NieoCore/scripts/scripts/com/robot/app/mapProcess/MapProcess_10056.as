package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.control.SkyTrainController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alert;
   
   public class MapProcess_10056 extends BaseMapProcess
   {
      
      public function MapProcess_10056()
      {
         super();
      }
      
      override protected function init() : void
      {
         SkyTrainController.getInstance().init(this);
      }
      
      override public function destroy() : void
      {
         SkyTrainController.getInstance().destroy();
      }
      
      public function onLeaveMap() : void
      {
         Alert.show("是否要离开空中列车？中途离开的话，再次进入需要从头开始挑战哦！",function():void
         {
            SkyTrainController.getInstance().leaveGame();
         });
      }
   }
}

