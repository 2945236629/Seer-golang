package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1826;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10377 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10377()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1826.completeNode3();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HUANGJINTIANMA,["为什么会这样？从前第六星系都是畅行无阻的，难道里面有什么不可告人的秘密？"],["这也是我们想知道的。"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["这个迷宫看来是唯一的入口，不过里面机关重重，我们找不到正确的方向，只能拜托你了！"],["修建这个迷宫的目的是什么呢？"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["我推测迷宫是为了挡住别人进入，但是一定有正确的方向通往第六星系，因为有人只想自己利用这个通道。"],["很有道理，通道一定是存在的。"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HUANGJINTIANMA,["那我尽力用我记忆中残存的印象感应一下，应该可以找到第六星系的位置。"],["拜托你了，黄金天马！"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["梦境之神？你怎么也离开了第六星系？"],["我是来引导你们的。"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["你们实在太愚蠢了，被索伦森欺骗了太久，身为创世六神兵，你们怎么可以相信创世之神的敌人？"],["你的意思是？"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["所以创世之神根本没有死，都是索伦森在欺骗我们？"],["那倒不是，创世之神确实已经……"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["你们也知道的，魔域一直反对创世之神，尽管我们尽力平息矛盾，可是根本不能化解他们的仇恨……"],["可是索伦森并不是这样说的……"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DAFUNI,["不过回想一下，索伦森的言辞似乎也很模糊，并不值得相信……"],["因为他根本就在撒谎！"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["索伦森想要称霸第六星系，创世之神临死前将他封印起来，没想到他居然跑到了外面，如果让他回去了，后患无穷……"],["索伦森的野心确实非常明显。"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DAFUNI,["赫尔墨斯，我们还是应该尽快先返回第六星系了解一切，你能带领我们先回去吗？"],["这个当然可以。"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["我们设下结界的目的就是为了阻挡索伦森，他在第六星系之外力量会被削弱，我们要趁这个机会消灭他！"],["既然是个祸患，我们早晚需要解决。"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_];
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskMC"] as MovieClip;
      }
      
      override public function destroy() : void
      {
         this._taskMC = null;
         super.destroy();
      }
   }
}

