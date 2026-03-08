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
   
   public class MapProcess_10487 extends BaseMapProcess
   {
      
      public function MapProcess_10487()
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
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["尤曼斯！你怎么样？发生了什么事情？"],["刚才科塔娜和特蒙勒攻击我们！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["海盗集团已经把我们的城堡掠夺一空！他们是在寻找我们所控制的魔石能量！"],["魔石能量？"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["是的！魔灵王就是依靠着魔石能量才变得如此巨大！而拥有魔石能量便可以创作出实力非凡的精灵！"],["难以想象！"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["看来魔灵王的复苏，一定又是宇宙的大灾难！"],["我们必须阻止他们！"]);
         mod6 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["我要消灭所有的魔石精灵！我要消灭所有的海盗！我要消灭魔灵王！！！"],["可恶的海盗集团！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["为什么所有的邪恶势力都有海盗集团！我们这次一定要把海盗集团彻底消灭！这样魔灵王就根本没办法创造魔石精灵！"],["大家不能轻举妄动！"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,["海盗集团一定布下了天罗地网，等着我们前去，我们必须找到一个万全之策，才能够消灭他们！"],["万全之策？"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["我的家园都被他们毁了！我要让他们血债血偿！"],["小心！"]);
         mod11 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,mod11],function():void
         {
            TaskController_1981.completeNode3();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

