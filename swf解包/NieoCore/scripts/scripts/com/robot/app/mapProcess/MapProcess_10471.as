package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1966;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10471 extends BaseMapProcess
   {
      
      public function MapProcess_10471()
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
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["不用着急！这才刚刚开始！接下来，你会一步步的走向魔王的道路，成为我们新的魔君！    "],["你说什么？"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["不要紧张！索伦森烟消云散之后，主人需要新的寄体。而我就需要帮助主人塑造新的寄体，现在就是你！"],["呵！可笑！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAXIUSI,["你以为谁都要任你们摆布吗？  "],["难道不是吗？"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["之前派出去的赛小息已经成功窃取了赛尔飞船的数据！接下来就是我们大举进攻的时刻了！"],["遵命！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KETANA,["海盗集团的飞船已经修复完成，随时可以向赛尔飞船开战！"],["哈哈哈！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.TEMENGLE,["从此宇宙中再也没有我们的对手了！整个宇宙都将臣服！"],["痴心妄想！"]);
         mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9],function():void
         {
            TaskController_1966.completeNode2();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

