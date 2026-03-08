package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1981;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10488 extends BaseMapProcess
   {
      
      public function MapProcess_10488()
      {
         super();
      }
      
      override protected function init() : void
      {
         var mod1:TaskMod;
         var mod2:TaskMod;
         var mod3:TaskMod;
         var mod4:TaskMod;
         var mod5:TaskMod;
         var mod6:TaskMod;
         var mod7:TaskMod;
         var mod8:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["你们这些邪恶的家伙！都给我出来！我今天要让你们付出代价！"],["小心！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["这里如此平静，一定有阴谋！"],["哈哈哈！"]);
         mod4 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod5 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1981_1",true]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["什么！魔石精灵居然会这样！地狱兽能够瞬间裂变！"],["我们需要请求支援！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["大家不要放弃，我们一定能够取得这场战役的胜利！"],["先锋队必胜！"]);
         mod8 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1981_2",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8],function():void
         {
            TaskController_1981.completeNode4();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

