package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1820;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10373 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10373()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1820.completeNode3();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AIXINGE,["主人，难道没有可以快速恢复的办法吗？或者哪里有力量强大的神医？"],["你这么一说我想起来了。"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["创世六神兵中的圣戒之灵代表的是体力值，拥有坚韧不屈的体质，独特的医疗回复能力更是无人能及。"],["那我们快去找他吧！"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AIXINGE,["如果他愿意帮助我们就好了，只不过创世六神兵和我们似乎并不友善，恐怕很难说服他吧……"],["我有办法的，先把他找来。"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["我可并不想见你，你怎么也跑到第六星系外面来了？"],["这个说来话长了。"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["现在我和谱尼交手受了点伤，需要你医治一下，强大的圣戒之灵，你一定会帮我的，对吧？"],["那可不一定。"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["算起来我们还曾经是敌人，我为什么要帮你，如果没什么事我先走了。"],["先慢点走，我有你感兴趣的东西。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["我已经掌握了传说中的重生之术，只要你愿意治好我，我就可以重生你的妹妹，难道你不想念她吗？"],["重生之术？真的假的？"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["这样强大的法术确实不好施展，但是，只要我完全恢复，一定可以重生你的妹妹，就像重生艾辛格和伊兰迪他们一样。"],["可是我并不想帮助你。"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["我……考虑一下吧，和你做交易是非常危险的，我不知道会隐藏着什么样的危险。"],["这个你就放心吧。"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["我可是非常诚信的，只要我恢复了，重生你的妹妹只是举手之劳。"],["听起来不错，但是……"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_];
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

