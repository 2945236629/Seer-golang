package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_930 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_930()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86058877);
         this.cls = getDefinitionByName("com.robot.app2.control.WeeklyActivity2Controller");
         this.btnLevel["longMc"].addEventListener(MouseEvent.CLICK,this.onClickOpenSummerPanel);
      }
      
      private function onClickOpenSummerPanel(param1:MouseEvent = null) : void
      {
         this.btnLevel["longMc"].visible = false;
         this.cls.initForMap();
         this.btnLevel["longMc"].visible = true;
      }
      
      override public function destroy() : void
      {
      }
   }
}

