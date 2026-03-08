package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_947 extends BaseMapProcess
   {
      
      public function MapProcess_947()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86070651);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_yulingshi").initForMap(this);
         DisplayUtil.removeForParent(conLevel["animate_mc1"]);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_yulingshi").destroy();
         super.destroy();
      }
   }
}

