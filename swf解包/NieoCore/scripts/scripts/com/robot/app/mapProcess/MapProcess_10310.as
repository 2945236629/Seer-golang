package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1546;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.event.MapEvent;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10310 extends BaseMapProcess
   {
      
      public function MapProcess_10310()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.taskList,this.endTaskHandler);
      }
      
      protected function endTaskHandler() : void
      {
         MapManager.changeMap(91);
         MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,function(param1:MapEvent):void
         {
            TasksManager.complete(TaskController_1546.TASK_ID,0);
            MapManager.removeEventListener(MapEvent.MAP_SWITCH_COMPLETE,arguments.callee);
            SocketConnection.send(1022,86058352);
         });
      }
      
      private function get taskList() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XINJIDE,["迪恩…你还是属于这里的，只有在这里你才能获得更强大的能量！"],["你的朋友看来是来不了了！"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XINJIDE,["放心…就像那次一样，我依旧会把您打造成最强的战士！"],["我们开始吧！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["等等…谁说我来不了了？我这不是赶来了吗？辛基德，作为迪恩的战友，我可不弱哦！"],["恩…看来有点实力！"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["武器大师…我很尊敬您，所以这次就拜托了，救救迪恩吧！"],["放心吧！只要零件足够，我一定会尽力的！"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["武器大师这些够吗？如果不够我拆掉自己身上的零件给你，只要能拯救迪恩，我什么都愿意！"],["贾斯汀你果然够义气！"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XINJIDE,["这些东西你先收起来吧！我武器大师可不是浪得虚名，迪恩就交给我吧！"],["有劳了！"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,4,"mc4"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XINJIDE,["我的机器也早已经老化了，与其等着这些零件生锈，还不如为这些零件找到适合的主人，这样才是我武器大师的追求！"],["可是…"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,5,"mc5"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XINJIDE,["差不多了…我的任务终于完成了，贾斯汀你的伙伴迪恩已经没什么大碍了！"],["我也该好好休息一下了！"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["武器大师感谢你的奉献，你的恩情我贾斯汀必定铭记于心！"],["每个人都有自己的使命！"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIEN_20130614,["辛基德…你不能休息，我们还要联手一起击败海盗集团呢！难道你想离我而去吗？"],["看来这个任务需要你独自完成了!"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,6,"mc6"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["伟大的武器大师…我是不会忘记你的！迪恩，咱们走吧！回到赛尔号去，那里才是你的家！"],["不！！！我不会离开这里的！"]);
         var _loc17_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["怎么了…为什么你还要留在这里呢！武器大师将你修复是希望你和我再一次的并肩作战，难道你不想吗？"],["正因为这样，我更不能离开这里！"]);
         var _loc18_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,7,"mc7"]);
         var _loc19_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIEN_20130614,["贾斯汀你走吧！回到太空站去，你是站长！赛尔号和太空站都需要你！"],["那你为什么不和我一起走呢！"]);
         var _loc20_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIEN_20130614,["是武器大师造就了我，我只要在这里保护着它！况且我已经不是你们那个空间的人了，难道你忘记我的能量只能维持10分钟吗？"],["可是…"]);
         var _loc21_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIEN_20130614,["不要可是了…如果你还是曾经的贾斯汀的话，就马上给我走！我答应你只要赛尔号遇到危险，我迪恩一定会及时赶到的！"],["好吧！既然你不走我也不想逼你！\t"]);
         var _loc22_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,8,"mc8"]);
         var _loc23_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIEN_20130614,["保重吧！贾斯汀，我们一定还会再见的！"],["..迪恩你也是！你给我好好的活着！"]);
         var _loc24_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["再见了，曾经的战友！我很期待咱们下一次的并肩作战！"],["一定会的！"]);
         var _loc25_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,9,"mc9"]);
         var _loc26_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["迪恩…想念我们的时候记得回来哦！赛尔号上你的房间我们一直为你保留着！"],["你们有心了！"]);
         var _loc27_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_10310_2"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_,_loc19_,_loc20_,_loc21_,_loc22_,_loc23_,_loc24_,_loc25_,_loc26_,_loc27_];
      }
      
      private function get taskMc() : MovieClip
      {
         if(conLevel == null)
         {
            return null;
         }
         return conLevel["taskMc"];
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

