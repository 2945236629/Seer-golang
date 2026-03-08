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
   
   public class MapProcess_10465 extends BaseMapProcess
   {
      
      public function MapProcess_10465()
      {
         super();
      }
      
      override protected function init() : void
      {
         var mod1:TaskMod;
         var mod2:TaskMod;
         var mod3:TaskMod;
         var mod4:TaskMod;
         var mod6:TaskMod;
         var mod7:TaskMod;
         var mod8:TaskMod;
         var mod9:TaskMod;
         var mod10:TaskMod;
         var mod12:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KETANA,["就是把你们引来，接受我们的折磨！一点点的摧毁赛尔号！"],["赛…赛小息呢？"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["你们把赛小息带去哪里了啊？他为什么又突然消失了！你们怎么又开始与我们作对了？"],["真是麻烦啊！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KETANA,["一大堆问题！该先回答哪个呢？不如先慢慢折磨你们再说吧！ "],["可恶！"]);
         mod6 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.CHUANGSIBINGHUN,["大家快走！赛小息根本只是他们的复制品。特蒙勒与科塔娜已经被重新激发出了魔性！"],["怎么会这样！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,["那赛小息在哪里啊？我们该怎么办？卡修斯也会变成这样吗？"],["想走？没那么容易了！"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KETANA,["你们已经完全被奥罗纳尔大人掌控了！识相的话，就乖乖的听命于我们！否则我们可不客气！"],["可恶！"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["我们是绝对不会认输的！让我们向你们这些邪恶的家伙低头，休想！"],["还真是有骨气啊！"]);
         mod12 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod6,mod7,mod8,mod9,mod10,mod12],function():void
         {
            TaskController_1962.completeNode3();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

