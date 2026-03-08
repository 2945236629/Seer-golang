package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1996;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10506 extends BaseMapProcess
   {
      
      public function MapProcess_10506()
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
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["既然没办法，就算了吧！我不为难你！我只是为你感到可惜而已！"],["对不起！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["父亲大人！这是最后一次。下次，我绝对不会放过他们兄妹！"],["你确定？"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["你要知道，耶里梅斯从小就嫉妒你天赋异禀，担心你与他争夺天蛇星盟主的位置！"],["请您不要说了！"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["最后，天蛇七魔将竟然将幼小的你扔到荒芜一人的妖石山，让你自生自灭！"],["我说请您不要说了！"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["我为你感到不值得！他们对你凶狠手辣，你却还对他们抱有怜悯之心！"],["我说请你不要说了！！！"]);
         mod7 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["这里还轮不到你说话！当初如果不是你逼迫索伦森，我们现在也不会这么被动！"],["都过去了！"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["魔灵王，你也不要太在意了！索伦森的消亡是我们的重大损失！但是你和索伦森依然是部落最强大的国师！"],["谢少主称赞"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["现在最紧要的是需要找到魔石的能量，可是现在战神联盟处处阻拦我们！想要复兴部落……真是天方夜谭！"],["父亲大人，对不起！"]);
         mod11 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1996_1",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,mod11],function():void
         {
            TaskController_1996.completeNode2();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

