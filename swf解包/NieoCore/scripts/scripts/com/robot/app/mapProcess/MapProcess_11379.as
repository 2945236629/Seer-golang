package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import flash.events.MouseEvent;
   
   public class MapProcess_11379 extends BaseMapProcess
   {
      
      public function MapProcess_11379()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(conLevel["npc"],this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var taskMod:TaskMod;
         var e:MouseEvent = param1;
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         taskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HUGH,["欢迎来到星云边际！"],["谢谢！"]);
         taskMod.isNewDialog_1 = true;
         TaskDiaLogManager.single.playStory([taskMod],function():void
         {
            MapManager.changeMapWithCallback(1,function():void
            {
               SocketConnection.send(45693,14,3);
               ModuleManager.showAppModule("ZLWSGetYellowPanel");
            });
         });
      }
      
      override public function destroy() : void
      {
         KTool.showMapAllPlayerAndMonster();
         super.destroy();
      }
   }
}

