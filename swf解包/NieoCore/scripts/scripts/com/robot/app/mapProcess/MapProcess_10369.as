package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1810;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10369 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10369()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1810.completeNode3();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["现在你该履行你的承诺了，快带我们去你找到我那个地方吧！"],["那个地方可不一般……"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HAKENSA,["当年我也是误打误撞到了那个地方，那里的能量强大而诡异，我一度庆幸找到那里，但是后来发现无法控制，就逃出来了……"],["那就是你找到永恒水晶的地方吧。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["这个你不用担心，去了那里我们自然有办法应付。"],["既然这样，那好吧。"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HAKESASI,["哈肯撒，你为什么要对我们龙族的同胞下手？难道你忘记了你身上也流淌着龙族的血？"],["你们又把我当同胞吗？"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HAKENSA,["从小你就是高高在上的王子，我就因为外表丑陋遭人遗弃，我早就发誓，总有一天你们会为此付出代价，我会成为龙族之王！"],["你怎么能这么说？"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HAKESASI,["是因为你心术不正老龙王才不愿传位给你，如果你能证明你能够领导龙族，龙王子的位置我甘愿让给你！"],["哼，说得好听。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["两位先住手，听我说几句。"],["你想要说什么？"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HAKESASI,["创世神兵，你们要与我们龙族为敌吗？哈肯撒是龙族的败类，今天我要替龙族清理门户！"],["你说谁是龙族的败类！"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["哈肯撒与我们还有约定，今天不如暂时收手，等到哈肯撒和我们的事情了结，你们再来处理你们的恩怨。"],["好，那我就等你们一下。"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_];
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskMC"] as MovieClip;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this._taskMC = null;
      }
   }
}

