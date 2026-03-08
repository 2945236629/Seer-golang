package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1952;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10455 extends BaseMapProcess
   {
      
      public function MapProcess_10455()
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
         var mod13:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,["怎……怎么会！卡修斯！你怎么变成卡茨了啊！ "],["不好！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["卡修斯的能量全部都流失了！现在已经开始出现能量退化了！卡修斯，坚持住！"],["没想到这么快！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.CHUANGSIBINGHUN,["当初卡修斯为了救大家，独自抵抗索伦森的能量！应该是那个时候受到了魔石的影响。这一切都是索伦森设的圈套。 "],["太可恶了！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ZOG,["哼！我劝你们还是小心点。等我们真正的制造出魔石精灵，你们的末日就到了！"],["魔石精灵？"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ALLISON,["不怕告诉你们！卡修斯就是因为受到了索伦森的魔石能量的影响才会变成这样！"],["那就等着瞧吧！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["你们不要得意！你们根本不可能得逞！胜利只属于我们正义的一方！"],["那就等着瞧吧！"]);
         mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.CHUANGSIBINGHUN,["拖得越久卡修斯的能量流失越严重！我们必须赶紧想办法帮助他！"],["现在怎么办啊？"]);
         mod11 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["现在战神联盟其他成员都不在身边！我们只能依靠自己了！"],["我们还可以寻求特蒙勒！"]);
         mod12 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.CHUANGSIBINGHUN,["他一定会帮助我们的！况且，他对于泰坦星系的过去也十分了解！"],["我们立即出发！"]);
         mod13 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ATIEDA,["卡茨！坚持住！你在我心中一直都是最厉害的战神联盟成员。"],["救助卡修斯！"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,mod11,mod12,mod13],function():void
         {
            TaskController_1952.completeNode3();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

