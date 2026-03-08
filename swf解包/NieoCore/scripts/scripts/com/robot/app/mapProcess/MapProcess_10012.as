package com.robot.app.mapProcess
{
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.controller.NewSeerTaskController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import org.taomee.events.SocketEvent;
   
   public class MapProcess_10012 extends BaseMapProcess
   {
      
      private static const ID:uint = 88;
      
      public function MapProcess_10012()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.y = 660;
         if(TasksManager.getTaskStatus(ID) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(ID,function(param1:Boolean):void
            {
               if(param1)
               {
                  startPro();
               }
            });
         }
         else if(TasksManager.getTaskStatus(ID) == TasksManager.ALR_ACCEPT)
         {
            this.startPro();
         }
      }
      
      private function startPro() : void
      {
         NpcDialog.show(NPC.SHAWN,[MainManager.actorInfo.formatNick + "，恭喜你成为赛尔号的正式船员，NONO是一个智能助手，可以帮助你处理很多繁杂的事物，例如训练精灵、记录航行日志等等。还等什么呢！赶紧领取吧！"],["可爱的NONO，我总算是把你盼来咯！"],[function():void
         {
            SocketConnection.send(1020,127);
            AnimateManager.playMcAnimate(topLevel["nono"],0,"",function():void
            {
               SocketConnection.send(1020,128);
               getNono();
            });
         }]);
      }
      
      private function getNono() : void
      {
         if(MainManager.actorInfo.hasNono == false)
         {
            SocketConnection.addCmdListener(CommandID.NONO_OPEN,this.onGetSucHandler);
            SocketConnection.send(CommandID.NONO_OPEN,1);
         }
         else
         {
            this.completeTask();
         }
      }
      
      private function onGetSucHandler(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.NONO_OPEN,this.onGetSucHandler);
         MainManager.actorInfo.hasNono = true;
         SocketConnection.send(CommandID.NONO_FOLLOW_OR_HOOM,1);
         this.completeTask();
      }
      
      private function completeTask() : void
      {
         NpcDialog.show(NPC.SEER,["嗯嗯，我们一起遨游宇宙！肖恩，我现在去实验室咯，博士还给我准备了一份神秘大礼呢！"],["去实验室找博士派特！"],[function():void
         {
            SocketConnection.send(1020,129);
            TasksManager.complete(ID,0,function(param1:Boolean):void
            {
               if(param1)
               {
                  NewSeerTaskController.startTask();
               }
            });
         }]);
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.y = 0;
      }
   }
}

