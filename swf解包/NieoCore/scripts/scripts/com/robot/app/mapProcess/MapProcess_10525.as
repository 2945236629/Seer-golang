package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3005;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.CommandID;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.AppModel;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.setTimeout;
   
   public class MapProcess_10525 extends BaseMapProcess
   {
      
      private var maliApp:AppModel;
      
      public function MapProcess_10525()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         setTimeout(this.MaliStart,2000);
      }
      
      private function MaliStart() : void
      {
         if(!this.maliApp)
         {
            this.maliApp = new AppModel(ClientConfig.getAppModule("smallGame/EllioneGame/EllioneGame"),"正在加载游戏");
            this.maliApp.setup();
            this.maliApp.sharedEvents.addEventListener("MaliPass",this.onMaliPass);
            this.maliApp.sharedEvents.addEventListener("MaliFail",this.onMaliFail);
         }
         SocketConnection.send(CommandID.JOIN_GAME,3);
         this.maliApp.show();
      }
      
      private function onMaliPass(param1:Event) : void
      {
         var e:Event = param1;
         this.maliApp.hide();
         SocketConnection.send(CommandID.GAME_OVER,1,1);
         TasksManager.complete(3005,1,function(param1:Boolean):void
         {
            var sucess:Boolean = param1;
            NpcDialog.show(NPC.YELIMEISI_XIE,["我们快走！冰封山巅的决战！究竟谁才能是最后的王者！"],["我们快去！"],[function():void
            {
               StartMovie();
            }]);
         });
      }
      
      private function onMaliFail(param1:Event) : void
      {
         var e:Event = param1;
         SocketConnection.send(CommandID.GAME_OVER,0,0);
         this.maliApp.hide();
         NpcDialog.show(NPC.MOLINGKING,["想走？哼！先经过暗夜对抗阵吧！"],["我一定能够击败你！","我不想看到阿萨斯！"],[function():void
         {
            SocketConnection.send(CommandID.JOIN_GAME,3);
            maliApp.show();
         },function():void
         {
            MapManager.changeLocalMap(4);
         }]);
      }
      
      public function StartMovie() : void
      {
         var mod1:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         var mod2:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["父亲大人！停止内心的杀戮吧！我们一起回到暗夜城，城里的精灵需要你的保护"],["闭嘴！"]);
         var mod3:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["阿萨斯！击败他！摧毁他！让波塞冬彻底消亡！彻底消失在这个世界里！"],["等等…暗夜城的精灵……"]);
         var mod4:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4],function():void
         {
            TaskController_3005.completeNode3();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.maliApp)
         {
            this.maliApp.sharedEvents.removeEventListener("MaliPass",this.onMaliPass);
            this.maliApp.sharedEvents.removeEventListener("MaliFail",this.onMaliFail);
            this.maliApp.destroy();
            this.maliApp = null;
         }
      }
   }
}

