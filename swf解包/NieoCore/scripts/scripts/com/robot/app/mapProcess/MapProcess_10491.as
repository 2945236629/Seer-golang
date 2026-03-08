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
   
   public class MapProcess_10491 extends BaseMapProcess
   {
      
      public function MapProcess_10491()
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
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["大家小心！感觉这里魔界的能量十分强烈！我们尽快离开这里！"],["快想想办法！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["这里一片沙漠，我们会不会被困死在这里啊！哎呀，想想我老爸还在家里等我呢！"],["别胡说八道！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,["我们的飞船有防雷电设备，但是依然被雷电击中，我想这里面一定有阴谋！"],["小心！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIYUSHOU,["想要拿到天神石？哼！只有魔灵王才能得到！你们休想！"],["是你们带我们来这里？"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["怎么样？我的雷电之力加上魔石的能量，滋味好受吗？"],["可恶！你们这些魔鬼！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["你们一定会受到正义的审判的！这个宇宙绝对不会允许你们为非作歹的！"],["宇宙物竞天择，以实力说话！"]);
         mod9 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1983_0",true]);
         mod10 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10],function():void
         {
            TaskController_1983.completeNode2();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

