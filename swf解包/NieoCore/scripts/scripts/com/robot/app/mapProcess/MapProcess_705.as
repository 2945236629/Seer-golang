package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task901;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_705 extends BaseMapProcess
   {
      
      public function MapProcess_705()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task901.initTaskForMap705(this);
         (conLevel["adventureInLava"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onBroadcast);
         ToolTipManager.add(conLevel["adventureInLava"],"熔岩石");
      }
      
      private function onBroadcast(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("AdventureInLavaInfo"),"正在打开面板……","活动时间：4月1日-4月7日：\n每天12:00-14:00");
      }
      
      public function goto_704() : void
      {
         MapManager.changeMap(704);
      }
      
      override public function destroy() : void
      {
         Task901.destory();
      }
   }
}

