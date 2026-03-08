package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   
   public class MapProcess_675 extends BaseMapProcess
   {
      
      public function MapProcess_675()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task_745.getInstance().init(this);
      }
      
      override public function destroy() : void
      {
         Task_745.getInstance().destroy();
      }
      
      public function petHandler(param1:MovieClip) : void
      {
         Task_745.getInstance().showPanel(param1);
      }
      
      public function bottomHandler() : void
      {
         Task_745.getInstance().unBt();
      }
   }
}

