package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3009;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import org.taomee.events.DynamicEvent;
   import org.taomee.manager.EventManager;
   import org.taomee.manager.ResourceManager;
   
   public class MapProcess_987 extends BaseMapProcess
   {
      
      public function MapProcess_987()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         if(TasksManager.getTaskStatus(3009) == TasksManager.ALR_ACCEPT)
         {
            TasksManager.getProStatusList(3009,function(param1:Array):void
            {
               if(Boolean(param1[1]) && !param1[2])
               {
                  openMoGeSiPuzzlePanel(true);
               }
               else if(Boolean(param1[2]) && !param1[3])
               {
                  pro2();
               }
            });
         }
      }
      
      private function pro1() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         ResourceManager.getResource(ClientConfig.getMapAnimate("map_987_0"),function(param1:MovieClip):void
         {
            var mod1:TaskMod;
            var mod2:TaskMod;
            var mod3:TaskMod;
            var mod4:TaskMod;
            var mod5:TaskMod;
            var mod6:TaskMod;
            var mod7:TaskMod;
            var taskMc:MovieClip = param1;
            MapManager.currentMap.controlLevel.addChild(taskMc);
            mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[taskMc,1,"mc1"]);
            mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["耶里梅斯是唯一可以消灭魔石的家伙！只要消灭他，宇宙中的魔石能量就全部归我了！"],["你找的是耶里梅斯，关我什么事？"]);
            mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["我最烦和我装糊涂的家伙！大家都知道，耶里梅斯消失之前，最后见过你！你肯定知道耶里梅斯去了哪里！"],["这……恐怕让你失望了！"]);
            mod4 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[taskMc,2,"mc2"]);
            mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["不知道耶里梅斯给你们什么好处！让你们这么死心塌地的对他！"],["你放开烈火犬！"]);
            mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["烈火犬跟这件事情无关，你放开他！"],["哦？是吗？"]);
            mod7 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[taskMc,3,"mc3"]);
            TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7],function():void
            {
               MapManager.currentMap.controlLevel.removeChild(taskMc);
               TaskController_3009.completeNode3(pro2);
            });
         });
      }
      
      private function pro2() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         ResourceManager.getResource(ClientConfig.getMapAnimate("map_987_1"),function(param1:MovieClip):void
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
            var taskMc:MovieClip = param1;
            MapManager.currentMap.controlLevel.addChild(taskMc);
            mod1 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["呵~没想到这里卧虎藏龙呀！暗金炎魔王，还有…圣…圣•萨瑞卡？"],["什么？"]);
            mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOHUA_SARUIKA,["谁是圣•萨瑞卡？"],["哈哈哈！真是老天助我！"]);
            mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["没想到我从上古而来，不仅得到魔石的能量，如今还让我遇到圣•萨瑞卡。只要我获得圣能量，整个宇宙我无人能敌！ "],["你什么意思？"]);
            mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["我的意思就是让你成为真正的圣•萨瑞卡！"],["大家小心"]);
            mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[taskMc,1,"mc1"]);
            mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOHUA_SARUIKA,["可恶！没想到他竟然有这么强大的能量！"],["他就是传说中的上古凶兽！"]);
            mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ANJINYANMOWANG,["他不是被上古战神封印了吗？怎么会出现在这里！"],["他被魔灵王解封，从远古召唤而来！"]);
            mod8 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_3009_2",true]);
            mod9 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_3009_0",true]);
            TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9],function():void
            {
               MapManager.currentMap.controlLevel.removeChild(taskMc);
               TaskController_3009.completeNode4();
            });
         });
      }
      
      private function onMoGeSiPuzzleComplete(param1:DynamicEvent) : void
      {
         var e:DynamicEvent = param1;
         this.openMoGeSiPuzzlePanel(false);
         if(e.paramObject.isWin)
         {
            NpcDialog.show(NPC.SEER,["庞贝古城？他们去庞贝古城做什么？尤曼斯和烈火犬还在那里，他们会不会有危险呀？我们快去帮助他们！"],["立即出发！"],[function():void
            {
               pro1();
            }]);
         }
         else
         {
            NpcDialog.show(NPC.MOGESI_YAOMO,["放弃了吗？放弃的话永远都无法成功的！你永远都只能是个失败者！"],["我绝对不会放弃的！","哎呦！今天天气不错哦！"],[function():void
            {
               openMoGeSiPuzzlePanel(true);
            }]);
         }
      }
      
      private function openMoGeSiPuzzlePanel(param1:Boolean) : void
      {
         if(param1)
         {
            EventManager.addEventListener("MoGeSiPuzzleComplete",this.onMoGeSiPuzzleComplete);
            ModuleManager.showModule(ClientConfig.getAppModule("MoGeSiPuzzlePanel"));
         }
         else
         {
            EventManager.removeEventListener("MoGeSiPuzzleComplete",arguments.callee);
         }
      }
   }
}

