package com.robot.app.mapProcess
{
   import com.robot.app.npc.taskPanel.NpcTaskPanel;
   import com.robot.app.task.taskscollection.Task1193;
   import com.robot.core.event.MapEvent;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.INpcModel;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcController;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_770 extends BaseMapProcess
   {
      
      public function MapProcess_770()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         var _loc1_:int = int(TasksManager.getTaskStatus(1193));
         if(_loc1_ == TasksManager.ALR_ACCEPT)
         {
            Task1193.initTaskFor770(this);
            getDefinitionByName("com.robot.app2.control.TermReviewController").unable(this);
         }
         else
         {
            Task1193.unable(this);
            getDefinitionByName("com.robot.app2.control.TermReviewController").initFor770(this);
         }
         SocketConnection.send(1022,86065582);
      }
      
      private function onClickZhu(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(TasksManager.getTaskStatus(1861) == TasksManager.UN_ACCEPT)
         {
            NpcDialog.show(NPC.SHIPER,["风暴之神阿洛纳斯现身创世遗迹！赫尔墨斯的狼子野心已经暴露。勇敢地赛尔们，一起去揭开星际迷雾吧！"],["船长，我们去看看吧！（前往船长室接取主线，奖励十万经验券，乐园代币X20！）","让我先准备一下！"],[function():void
            {
               SocketConnection.send(1022,86053057);
               MapManager.changeMap(4);
               MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,function(param1:*):void
               {
                  var _loc3_:* = undefined;
                  var _loc4_:* = undefined;
                  MapManager.removeEventListener(MapEvent.MAP_SWITCH_COMPLETE,arguments.callee);
                  NpcTaskPanel.setFocusTask(1861);
                  if(MapManager.currentMap.id == 4)
                  {
                     _loc3_ = getDefinitionByName("com.robot.app.npc.taskPanel.NpcTaskPanel");
                     _loc4_ = NpcController.getNpc(NPC.SHIPER) as INpcModel;
                     _loc3_.show(_loc4_.tasks,_loc4_.npcInfo);
                  }
               });
            }]);
         }
         else
         {
            MapManager.changeMap(4);
         }
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.TermReviewController").destroy();
      }
   }
}

