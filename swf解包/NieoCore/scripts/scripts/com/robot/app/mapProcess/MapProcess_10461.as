package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1960;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10461 extends BaseMapProcess
   {
      
      public function MapProcess_10461()
      {
         super();
      }
      
      override protected function init() : void
      {
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
         var mod14:TaskMod;
         var mod15:TaskMod;
         var mod16:TaskMod;
         var mod17:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["卡修斯！你不是想超进化吗？我帮你啊！让你成为战神联盟中实力最强大的一员！  "],["可恶！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAXIUSI_WHITE,["可恶，放开我！为什么我感觉到两股能量在体内冲撞！啊！！！"],["哈哈哈！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["放心！马上你原先的能量都会被我控制！还会有更多的魔石能量！你慢慢的就会听命于我的！  "],["可恶！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["想救卡修斯？想救赛小息？哈哈！看你们的选择吧！"],["什么意思？他要做什么？"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ATIEDA,["他带去卡修斯去哪里了啊？他到底是谁啊？赛小息在哪里啊！你出来！我要击败你！"],["不要慌！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.CHUANGSIBINGHUN,["我们一定要保持镇定！会有办法的！我们一定要冷静！我们不能慌乱！"],["你们被他控制了！"]);
         mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.TEMENGLE,["科塔娜之前被魔石的能量所蒙蔽！现在她的魔石能量已经消失了！大家不要误会她！"],["原来是这样！"]);
         mod11 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["如果卡修斯被魔石能量控制！那……卡修斯岂不是要与我们成为敌人？"],["没那么简单！"]);
         mod12 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KETANA,["卡修斯本身就能量异常！如果再加上魔石能量的控制——恐怕，危机到整个宇宙啊！"],["那么严重！"]);
         mod13 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ATIEDA,["那我们快找到卡修斯！千万不能让他被魔石能量控制啊！还有直到现在都不知道去哪儿的赛小息！"],["所以情况紧急！"]);
         mod14 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         mod15 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["所以，如果我们选择一扇门看过之后，未来的事情就会按照我们看到的事情发展？"],["传说中是这样的！"]);
         mod16 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.TEMENGLE,["传说神域天王就是看到了索伦森，所以才对魔域进行了疯狂的掠夺！结果还是没能控制索伦森！"],["太恐怖了！"]);
         mod17 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["卡修斯封神还是入魔！一切都有我们自己来选择了！"],["（选择任意一扇门，看到卡修斯的结局）"]);
         TaskDiaLogManager.single.playStory([mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod11,mod12,mod13,mod14,mod15,mod16,mod17],function():void
         {
            TaskController_1960.completeNode3();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

