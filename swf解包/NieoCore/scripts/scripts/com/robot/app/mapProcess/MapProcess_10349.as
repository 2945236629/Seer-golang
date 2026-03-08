package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1764;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10349 extends BaseMapProcess
   {
      
      public function MapProcess_10349()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1764.completeNode2();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["谱尼，快来看看我的杰作，通过这个逆界之门，我可以获得无尽的力量，即使是麒麟也无法做到吧！哈哈哈哈……"],["你这个疯子！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PUNI,["快毁了它，它的力量不是你能够预知，更不是你能控制的，会带来无尽的危险！"],["谱尼，你怎么这么胆小。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["谱尼，为什么你这么确定带来的就是危险？难道你知道什么吗？"],["我……我现在不能告诉你。"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["你知道我为了打造它耗费了多少心血吗？绝不能让你毁了！"],["玛法里奥，我是为你好！"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PUNI,["快点清醒吧！不要被这股邪恶的力量侵蚀了你的心智，我认识的那个正直的玛法里奥呢？"],["我一直很正直！"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["有了它我才可以打败麒麟，谱尼， 你不愿意帮我，也不要想来阻止我！"],["真是执迷不悟！"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PUNI,["玛法里奥，你怎么这么争强好胜，看来我的想法没错，麒麟比你更适合做星系守护神！"],["谱尼，你说什么？"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PUNI,["玛法里奥，你一定要我们两败俱伤你才满意吗？"],["我不想与你为敌。"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["谱尼，你是我的朋友，但是你不要阻止我，打败麒麟是我的夙愿，只有我才配做星系守护神！"],["胜负真的那么重要吗？"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PUNI,["星系守护神就要维护宇宙的和平安宁，而不是不停给宇宙带来危险，就这一点，你不配！"],["我哪里带来危险了？"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["你究竟是谁？快放开谱尼！"],["我是暗黑魔君索伦森。"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["谢谢你了，没想到还有凡域的精灵可以打通魔域的通道，还送上了这么好的载体，这下我省事多了。"],["魔域的通道？"]);
         var _loc17_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PUNI,["玛法里奥，你唤醒了恶魔，这下真的无可挽回了……"],["我一定会挽回的。"]);
         var _loc18_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1764_1",true]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_];
      }
      
      private function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["taskMC"] as MovieClip;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

