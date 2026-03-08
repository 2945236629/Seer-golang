package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   
   public class MapProcess_10469 extends BaseMapProcess
   {
      
      public function MapProcess_10469()
      {
         var mod1:TaskMod;
         var mod2:TaskMod;
         super();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["首先，快领取你的回归见面礼吧，现在只是船长的一点小意思！你" + "0xff0000后面几天坚持连续登录，还能直接领取一只“满级绝版精灵0xffffff" + "哟！"],["领取回归见面礼！"]);
         SocketConnection.send(1022,86070607);
         TaskDiaLogManager.single.playStory([mod1],function():void
         {
            TaskDiaLogManager.single.destroy();
            NpcDialog.show(NPC.SHIPER,["首先，快领取你的回归见面礼吧，现在只是船长的一点小意思！你" + "0xff0000后面几天坚持连续登录，还能直接领取一只“满级绝版精灵0xffffff" + "哟！"],["领取回归见面礼！"],[function():void
            {
               startTwoStep();
            }]);
         });
      }
      
      override protected function init() : void
      {
      }
      
      private function startTwoStep() : void
      {
         var mod3:TaskMod = null;
         var mod4:TaskMod = null;
         var GET_TASK:uint = 0;
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["现在，快点击游戏界面左侧的" + "“0xff0000回归向导”图标0xffffff" + "，就能每天持续领取真正的大奖——" + "0xff0000老兵回归七重喜0xffffff" + "，还有多只0xff0000绝版满级精灵0xffffff等你拿哟！"],["哇塞，好期待啊！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["点击回归向导面板上的" + "0xff0000“我错过的精彩”按钮0xffffff" + "，就能查看你离开的这段时间，赛尔号发生了什么，快试一下吧！"],["嗯嗯，谢谢船长！"]);
         GET_TASK = 1968;
         TasksManager.accept(GET_TASK,function(param1:Boolean):void
         {
            var b1:Boolean = param1;
            TasksManager.complete(GET_TASK,0,function(param1:Boolean):void
            {
               var b2:Boolean = param1;
               SocketConnection.send(1022,86070608);
               TaskDiaLogManager.single.playStory([mod3,mod4],function():void
               {
                  KTool.showMapAllPlayerAndMonster();
                  MainManager.actorModel.x = 104;
                  MainManager.actorModel.y = 446;
                  MapManager.currentMap.controlLevel["animationContainer"].visible = false;
                  BufferRecordManager.setState(MainManager.actorInfo,1092,true);
               });
            });
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

