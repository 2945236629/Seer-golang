package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1952;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10453 extends BaseMapProcess
   {
      
      public function MapProcess_10453()
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
         super.init();
         if(TasksManager.getTaskStatus(1952) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(1952);
         }
         mod1 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,[MainManager.actorInfo.formatNick + "，你来得正好。派特博士有重大的发现，赛小息带回来的泰坦石能量，居然能够吸收周围的能量！ "],["什么？"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["吸收周围的能量？怎么会这样？泰坦石虽然蕴含着巨大的能量，但是难道还能吸收能量？"],["不是的！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["经过派特博士的缜密分析——这根本不是泰坦石！而是一种神秘恐怖的物质——魔石！ "],["魔石？"]);
         mod4 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["我已经命令派特博士将收集回来的物质放到了飞船的真空仓，以待后续进行更精确的研究！ "],["好的，那我们怎么办？"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["据我估计，能够利用宇宙中的能量，创造出神秘人物的只有一个组织。 "],["海盗集团？"]);
         mod7 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["赛尔先锋队，你们去海盗基地调查一下，看一看到底是否真的有异常情况！"],["遵命！"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["不管怎么样，大家一定要稳住！这个事情非同小可，随时向我汇报最近情况！"],["放心吧，船长！"]);
         mod10 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1952_3",true]);
         KTool.hideMapAllPlayerAndMonster();
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9],function():void
         {
            TaskController_1952.completeNode1();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

