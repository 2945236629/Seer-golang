package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1998;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10509 extends BaseMapProcess
   {
      
      public function MapProcess_10509()
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
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOTUOTUO,["刚才抓走缪斯的是伊洛维奇！是暗夜城少主的儿子！"],["暗夜城少主？"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOTUOTUO,["是的！索伦森和魔灵王都是暗夜城的国师！可惜，现在暗夜城已经灭亡了！暗夜城的城主也死了！只剩下暗夜城的少主——阿萨斯！"],["那…那个伊洛维奇为什么抓走缪斯？"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOTUOTUO,["那我就不知道了！但是他们一定去了棱石星！因为暗夜城就隐藏在棱石星！"],["那我们立即出发！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOTUOTUO,["是…是…是的！她应该被带去了棱石星！应…应…应该吧！"],["事不宜迟！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["我们立即前往棱石星，敢暗算缪斯，我一定让他彻底灰飞烟灭！"],["等等，不要冲动！"]);
         mod8 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8],function():void
         {
            TaskController_1998.completeNode1();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

