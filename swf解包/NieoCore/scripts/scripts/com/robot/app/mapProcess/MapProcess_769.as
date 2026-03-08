package com.robot.app.mapProcess
{
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alarm;
   
   public class MapProcess_769 extends BaseMapProcess
   {
      
      public function MapProcess_769()
      {
         super();
      }
      
      override protected function init() : void
      {
         Alarm.show("青龙祭坛暂时关闭，期待它的再次开放吧！",function():void
         {
            MapManager.changeMap(1);
         });
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

