package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_743;
   import com.robot.app.task.taskscollection.Task743;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   
   public class MapProcess_10379 extends BaseMapProcess
   {
      
      public function MapProcess_10379()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["kazi2MC"].visible = false;
         conLevel["kaziMC"].visible = false;
         conLevel["black1MC"].visible = false;
         conLevel["black2MC"].visible = false;
         if(TasksManager.getTaskStatus(TaskController_743.TASK_ID) == TasksManager.ALR_ACCEPT)
         {
            Task743.initTaskForMap445(this);
            return;
         }
         conLevel["kaxiusiMC"].buttonMode = true;
         conLevel["kaxiusiMC"].addEventListener(MouseEvent.CLICK,this.kaxiusiClickHandler);
      }
      
      private function kaxiusiClickHandler(param1:MouseEvent) : void
      {
         NpcDialog.show(NPC.KAXIUSI_WHITE,["守护炫彩山是我的使命！"],["嗯，你好好站岗吧，我顶你！"]);
      }
      
      override public function destroy() : void
      {
         Task743.destroy();
         conLevel["kaxiusiMC"].removeEventListener(MouseEvent.CLICK,this.kaxiusiClickHandler);
         ModuleManager.destroy(ClientConfig.getAppModule("HolePanel"));
      }
      
      public function gotoHoleFight() : void
      {
         SocketConnection.send(1022,86053859);
         ModuleManager.showModule(ClientConfig.getAppModule("HolePanel"),"炫彩山山洞入口面板");
      }
   }
}

