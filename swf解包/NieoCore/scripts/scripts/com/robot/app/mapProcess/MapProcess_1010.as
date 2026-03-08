package com.robot.app.mapProcess
{
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_1010 extends BaseMapProcess
   {
      
      public function MapProcess_1010()
      {
         super();
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("魔界的挑衅邪恶魔神（2014.07.018）","进入绝望魔域",StatManager.RUN_ACT);
      }
      
      override public function destroy() : void
      {
      }
   }
}

