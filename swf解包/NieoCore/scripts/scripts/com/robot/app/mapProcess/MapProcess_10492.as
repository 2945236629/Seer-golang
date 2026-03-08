package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1983;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10492 extends BaseMapProcess
   {
      
      public function MapProcess_10492()
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
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["大家小心！不要被魔灵王控制！"],["让我看到你们的内心！"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["进入幻化之境吧！你会实现自己的梦想的！"],["不要啊！！！"]);
         mod3 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["阿铁打！你是不是感觉到全身充满力量呢！"],["是啊！我感觉我就是世界的霸主！"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["如果让你成为我的助手，你愿意吗？我要得到赛尔号的飞船资料！你会帮助我吗？"],["愿意！愿意！"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ATIEDA,["只要你能够让我成为全宇宙最厉害的赛尔，打遍天下无敌手的赛尔！我什么都听你的！"],["哈哈哈！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["没想到你们这些铁皮人都有这么强大的欲望！真是让人觉得可笑啊！"],["还有那个赛小息呢！"]);
         mod8 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["你只要听从我的安排，我就可以让你打败阿铁打！"],["真的吗？"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["当然！只要你告诉我赛尔号飞船的所有资料！等我彻底摧毁赛尔号的那一天，你就可以打败阿铁打了！"],["你休想！"]);
         mod11 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,mod11],function():void
         {
            TaskController_1983.completeNode3();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

