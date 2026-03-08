package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1962;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10464 extends BaseMapProcess
   {
      
      public function MapProcess_10464()
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
         var mod9:TaskMod;
         var mod10:TaskMod;
         var mod11:TaskMod;
         var mod12:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["你们居然还敢追过来！不自量力！别忘了，你们的魔石能量都是我给你们的！   "],["对付你足够了！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.TEMENGLE,["在无间境地，奥斯卡已经帮我们将所有的魔石能量消掉了。为了弥补我们的过错，我们绝不允许你再做坏事！"],["呵！可笑！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["大言不惭！那就让我看看你们的实力能不能阻挡我。  "],["出手吧！"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KETANA,["让我们之间做一个了断。让魔石精灵彻底在宇宙中消亡吧！  "],["尽管来啊！"]);
         mod6 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_ 1962_1",true]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["哈哈！魔石能量反而被我激发了！记住，你们永远都是魔石精灵！你们的使命就是帮助我们称霸所有星系！"],["遵命！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["当然，不久之后，传说中的战神联盟成员——卡修斯，都将成为魔石精灵中的一员！"],["哈哈哈！"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.TEMENGLE,["主人！接下来，我们该怎么办？"],["去魔窟之境！"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["赛小息已经带领赛尔先锋队前往魔窟之境了！接下来，就是我们一举歼灭他们的时候！"],["赛小息？他不是失踪了！"]);
         mod11 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["哈哈哈！拥有魔石，随时都可以复制一个！去吧！魔化卡修斯，即将来临！"],["遵命！"]);
         mod12 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,mod11,mod12],function():void
         {
            TaskController_1962.completeNode2();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

