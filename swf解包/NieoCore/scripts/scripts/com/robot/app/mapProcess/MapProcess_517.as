package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.*;
   import com.robot.app.task.taskUtils.manage.*;
   import com.robot.app.task.taskUtils.taskDialog.*;
   import com.robot.core.*;
   import com.robot.core.animate.*;
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import com.robot.core.npc.*;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.*;
   import org.taomee.manager.*;
   import org.taomee.utils.*;
   
   public class MapProcess_517 extends BaseMapProcess
   {
      
      private var _btn:SimpleButton;
      
      public function MapProcess_517()
      {
         super();
      }
      
      override protected function init() : void
      {
         this._btn = conLevel["beideerBtn"];
         ToolTipManager.add(this._btn,"马年第四只年兽“水云战骑”贝德尔降临");
         this._btn.addEventListener(MouseEvent.CLICK,this.onClickBtn);
      }
      
      private function onClickBtn(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         StatManager.sendStat2014("水云战骑贝德尔2014年兽四","开始前置剧情",StatManager.RUN_ACT);
         if(!BitBuffSetClass.getState(22544))
         {
            KTool.hideMapAllPlayerAndMonster();
            ResourceManager.getResource(ClientConfig.getMapAnimate("map_517_5"),function(param1:MovieClip):void
            {
               topLevel.addChild(param1);
               startStory(param1);
            },"item");
         }
         else
         {
            ModuleManager.showModule(ClientConfig.getAppModule("MonsterNian2014MainPanel"));
         }
      }
      
      private function startStory(param1:MovieClip) : void
      {
         var mc:MovieClip = null;
         mc = param1;
         LevelManager.closeMouseEvent();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[mc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LONGZUN,["不愧是太古邪神，不过我不能放弃！"],["哼哼，强弩之末！"]);
         mod3 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[mc,2,"mc2"]);
         mod4 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1970_5",true]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUJIAERDE,["好事多磨啊，又来一个送死的！"],["别太猖狂了！"]);
         mod6 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[mc,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6],function():void
         {
            LevelManager.openMouseEvent();
            KTool.showMapAllPlayerAndMonster();
            DisplayUtil.removeForParent(mc);
            BitBuffSetClass.setState(22544,1);
            StatManager.sendStat2014("水云战骑贝德尔2014年兽四","成功完成前置剧情",StatManager.RUN_ACT);
         });
      }
      
      private function horseYearMonsterPre(param1:MovieClip) : void
      {
         var mc:MovieClip = null;
         mc = param1;
         SocketConnection.send(1022,86067617);
         LevelManager.closeMouseEvent();
         KTool.hideMapAllPlayerAndMonster();
         AnimateManager.playMcAnimate(mc,1,"mc1",function():void
         {
            NpcDialog.show(NPC.SUJIAERDE,["龙尊，该是你付出代价的时刻了。今天就是你的末日！"],["别太自大！"],[function():void
            {
               NpcDialog.show(NPC.LONGZUN,["当初能够将你封印，如今，就依然可以！ 天幕四龙将不会白白牺牲的！"],["你以为你还会有机会吗？"],[function():void
               {
                  AnimateManager.playMcAnimate(mc,2,"mc2",function():void
                  {
                     mc.gotoAndStop(3);
                     NpcDialog.show(NPC.SUJIAERDE,["哈哈哈哈！龙尊，你也有今天！我说过，今天就是你的末日！"],["你想怎么样？"],[function():void
                     {
                        AnimateManager.playMcAnimate(mc,3,"mc3",function():void
                        {
                           NpcDialog.show(NPC.BOENNI,["失败者终究是失败者，你再怎么折腾也不是龙尊大人的对手，我劝你早点认输吧，不然下场可就……"],["不用你的来提醒我！"],[function():void
                           {
                              NpcDialog.show(NPC.XIELONGZUN,["难道……必须要唤醒他？不行，那个家伙太危险了！"],["你在那里嘀咕什么呢？"],[function():void
                              {
                                 AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("active2014032086789"),function():void
                                 {
                                    AnimateManager.playMcAnimate(mc,4,"mc4",function():void
                                    {
                                       NpcDialog.show(NPC.XIELONGZUN,["介绍一下，这是我在天幕地宫里数千年囚徒生涯中的朋友，太古邪神——苏尔加德，算起来他也是龙尊的老熟人了。"],["这些看来就是龙尊的手下了吧。"],[function():void
                                       {
                                          NpcDialog.show(NPC.NADAER,["果然让你盘踞着天幕宫殿后患无穷，不过这一切今天都会结束了！"],["好大的口气啊！"],[function():void
                                          {
                                             NpcDialog.show(NPC.XIELONGZUN,["还要感谢龙尊，没有他的囚禁，我怎么会发现地宫里还有这样的秘密，哈哈哈……"],["你们猖狂的时候结束了！"],[function():void
                                             {
                                                AnimateManager.playMcAnimate(mc,5,"mc5",function():void
                                                {
                                                   LevelManager.openMouseEvent();
                                                   KTool.showMapAllPlayerAndMonster();
                                                   DisplayUtil.removeForParent(mc);
                                                   BitBuffSetClass.setState(22544,1);
                                                   SocketConnection.send(1022,86070643);
                                                });
                                             }]);
                                          }]);
                                       }]);
                                    });
                                 });
                              }]);
                           }]);
                        });
                     }]);
                  });
               }]);
            }]);
         });
      }
      
      override public function destroy() : void
      {
         this._btn.removeEventListener(MouseEvent.CLICK,this.onClickBtn);
         ToolTipManager.remove(this._btn);
         this._btn = null;
      }
   }
}

