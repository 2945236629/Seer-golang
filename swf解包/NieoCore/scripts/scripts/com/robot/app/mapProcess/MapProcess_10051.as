package com.robot.app.mapProcess
{
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.app.task.taskUtils.taskDialog.TaskStoryPlayer;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.MapEvent;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.PetFightModel;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.ui.alert.Alert;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gs.TweenLite;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ToolTipManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10051 extends BaseMapProcess
   {
      
      private static var _pro:int = 0;
      
      private static var _door_0:Array = [0,0,0,0,0,0,0,0];
      
      private static var _door_1:Array = [0,0,0];
      
      private var _index:int;
      
      private var _petPos_0:Array = [new Point(122,246),new Point(200,292),new Point(298,332),new Point(418,366),new Point(542,366),new Point(664,332),new Point(760,292),new Point(840,246)];
      
      private var _petPos_1:Array = [new Point(312,230),new Point(480,272),new Point(648,230)];
      
      public function MapProcess_10051()
      {
         super();
      }
      
      override protected function init() : void
      {
         PetFightModel.mode = PetFightModel.MULTI_MODE;
         PetFightModel.type = PetFightModel.FIGHT_DEMON_SPACE;
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         ToolTipManager.add(topLevel["bag"],"精灵背包");
         topLevel["bag"].addEventListener(MouseEvent.CLICK,this.onBagClick);
         ToolTipManager.add(topLevel["exit"],"空间裂缝");
         topLevel["exit"].addEventListener(MouseEvent.CLICK,this.onExitClick);
         if(!BufferRecordManager.getState(MainManager.actorInfo,889))
         {
            this.newStart_targetMc.visible = true;
            this.newStartPro_1();
         }
         else
         {
            DisplayUtil.removeForParent(this.newStart_targetMc);
         }
         if(Boolean(BufferRecordManager.getState(MainManager.actorInfo,889)) && _pro == 0)
         {
            this.startPro_0();
         }
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.onFightComplete);
         SocketConnection.addCmdListener(CommandID.EXIT_GHOST_SPACE,this.onExitGhostSpace);
      }
      
      private function newStartPro_1() : void
      {
         var story:Array;
         var storyPlayer:TaskStoryPlayer = null;
         this.newStart_targetMc.gotoAndStop(1);
         story = [[TaskStoryPlayer.MAP_MOVIE,[this.newStart_targetMc,1,"mc1"]],[TaskStoryPlayer.FUL_MOVIE,["active_20131108_4",true]],[TaskStoryPlayer.DIALOG,[NPC.YIZHAKE,["竟然敢偷袭我！"],["你是罪有应得！"]]],[TaskStoryPlayer.DIALOG,[NPC.YIZHAKE,["哈哈哈哈，不错嘛，你们两个都已经超进化了，看来当初把你们收进附魔空间是正确的，你们的确有着不错的能力，不过跟我比，你们还差的远呢！"],["我们一定要击败你，离开伏魔空间！"]]],[TaskStoryPlayer.DIALOG,[NPC.YIZHAKE,["今天姑且放过你们，不过告诉你们个秘密，就算你们3个都超进化了也未必是我的对手，哈哈哈哈！"],["！！！！！"]]],[TaskStoryPlayer.MAP_MOVIE,[this.newStart_targetMc,2,"mc2"]],[TaskStoryPlayer.DIALOG,[NPC.TAIWOSI,["凭伊扎克正常的实力，对付我们确实胜券在握。不过看来刚刚迪修卡那一击对他也造成了不小的伤害，否则他不会如此轻易放过我们！"],["说的没错，如果他痊愈归来，我们就危险了！"]]],[TaskStoryPlayer.DIALOG,[NPC.TAIWOSI,["加布，看来我们必须赶在伊扎克痊愈之前帮助你完成超进化，集合我们三人超进化的能力才有机会战胜他！"],["我一定会加倍努力的！"]]]];
         storyPlayer = new TaskStoryPlayer();
         storyPlayer.addStory(story);
         storyPlayer.storyEndCallback = function():void
         {
            storyPlayer.destory();
            BufferRecordManager.setState(MainManager.actorInfo,889,true);
            MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,function():void
            {
               MapManager.removeEventListener(MapEvent.MAP_SWITCH_COMPLETE,arguments.callee);
               ModuleManager.showModule(ClientConfig.getAppModule("JiabuEnvolutionPanel"));
            });
            MapManager.changeMap(14);
         };
         storyPlayer.start();
      }
      
      private function startPro_0() : void
      {
         AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("DemonSpaceSwf_1"),function():void
         {
            MainManager.actorModel.pos = new Point(480,120);
            TweenLite.to(MainManager.actorModel,0.5,{
               "x":480,
               "y":500,
               "onComplete":function():void
               {
                  AnimateManager.playMcAnimate(conLevel["boss"],1,"mc_1",function():void
                  {
                     _pro = 1;
                     startPro_1();
                  });
               }
            });
         });
      }
      
      private function startPro_1() : void
      {
         if(this.getIsClear(_door_0))
         {
            SocketConnection.addCmdListener(CommandID.ENTER_NEXT_STAGE,function():void
            {
               SocketConnection.removeCmdListener(CommandID.ENTER_NEXT_STAGE,arguments.callee);
               _pro = 2;
               startPro_2();
            });
            SocketConnection.send(CommandID.ENTER_NEXT_STAGE);
         }
         else
         {
            this._index = this.getRandomDoor(_door_0);
            AnimateManager.playMcAnimate(conLevel["boss"],2,"mc_2",function():void
            {
               conLevel["ani_0"].x = _petPos_0[_index].x;
               conLevel["ani_0"].y = _petPos_0[_index].y;
               AnimateManager.playMcAnimate(conLevel["ani_0"],0,"",function():void
               {
                  conLevel["pet_0"].x = _petPos_0[_index].x;
                  conLevel["pet_0"].y = _petPos_0[_index].y;
                  conLevel["pet_0"].gotoAndStop(_index + 1);
                  if(Math.random() < 0.5)
                  {
                     conLevel["dailog_0"].x = conLevel["pet_0"].x - 18;
                     conLevel["dailog_0"].y = conLevel["pet_0"].y - 128;
                     conLevel["dailog_0"].gotoAndStop(int(Math.random() * conLevel["dailog_0"].totalFrames) + 1);
                  }
                  conLevel["pet_0"].buttonMode = true;
                  conLevel["pet_0"].addEventListener(MouseEvent.CLICK,onFishClick);
               });
            });
         }
      }
      
      private function startPro_2() : void
      {
         AnimateManager.playMcAnimate(conLevel["boss"],3,"mc_3",function():void
         {
            ToolTipManager.add(conLevel["boss"],"加布");
            conLevel["boss"].buttonMode = true;
            conLevel["boss"].addEventListener(MouseEvent.CLICK,onBossClick);
         });
      }
      
      private function continuePro_2() : void
      {
         AnimateManager.playMcAnimate(conLevel["boss"],4,"mc_4",function():void
         {
            SocketConnection.addCmdListener(CommandID.ENTER_NEXT_STAGE,function():void
            {
               SocketConnection.removeCmdListener(CommandID.ENTER_NEXT_STAGE,arguments.callee);
               _pro = 3;
               startPro_3();
            });
            SocketConnection.send(CommandID.ENTER_NEXT_STAGE);
         });
      }
      
      private function startPro_3() : void
      {
         if(this.getIsClear(_door_1))
         {
            SocketConnection.addCmdListener(CommandID.ENTER_NEXT_STAGE,function():void
            {
               SocketConnection.removeCmdListener(CommandID.ENTER_NEXT_STAGE,arguments.callee);
               _pro = 4;
               startPro_4();
            });
            SocketConnection.send(CommandID.ENTER_NEXT_STAGE);
         }
         else
         {
            this._index = this.getRandomDoor(_door_1);
            AnimateManager.playMcAnimate(conLevel["boss"],2,"mc_2",function():void
            {
               conLevel["ani_1"].x = _petPos_1[_index].x;
               conLevel["ani_1"].y = _petPos_1[_index].y;
               AnimateManager.playMcAnimate(conLevel["ani_1"],0,"",function():void
               {
                  conLevel["pet_1"].x = _petPos_1[_index].x;
                  conLevel["pet_1"].y = _petPos_1[_index].y;
                  conLevel["pet_1"].gotoAndStop(_index + 1);
                  if(Math.random() < 0.5)
                  {
                     conLevel["dailog_1"].x = conLevel["pet_1"].x - 18;
                     conLevel["dailog_1"].y = conLevel["pet_1"].y - 128;
                     conLevel["dailog_1"].gotoAndStop(int(Math.random() * conLevel["dailog_1"].totalFrames) + 1);
                  }
                  conLevel["pet_1"].buttonMode = true;
                  conLevel["pet_1"].addEventListener(MouseEvent.CLICK,onFishClick);
               });
            });
         }
      }
      
      private function startPro_4() : void
      {
         AnimateManager.playMcAnimate(conLevel["boss"],5,"mc_5",function():void
         {
            ToolTipManager.add(conLevel["boss"],"加布");
            conLevel["boss"].buttonMode = true;
            conLevel["boss"].addEventListener(MouseEvent.CLICK,onBossClick);
         });
      }
      
      private function continuePro_4() : void
      {
         AnimateManager.playMcAnimate(conLevel["boss"],6,"mc_6",function():void
         {
            NpcDialog.show(NPC.JIABU,["败了，我竟然败了！看来只有你能帮助我了，陌生人！"],["这到底是怎么回事？！"],[function():void
            {
               NpcDialog.show(NPC.JIABU,["魔尊囚禁了我的孩子，以此威胁我，要我在这里为他效力万年！"],["魔尊？！他是谁？！"],[function():void
               {
                  NpcDialog.show(NPC.JIABU,["他控制了这里，虽然不知道他从哪来，但是他有着异常强大的能力，还好他本体现在不能出现，否则……不堪设想……"],null,null,false,function():void
                  {
                     NpcDialog.show(NPC.JIABU,["拜托你了，击败魔尊，救出我的孩子，阻止他的阴谋吧！"],["我一定会的，一切邪恶的力量都会以失败告终！"],[function():void
                     {
                        AnimateManager.playMcAnimate(conLevel["boss"],7,"mc_7",function():void
                        {
                           if(PetManager.containsBagForID(826))
                           {
                              ModuleManager.showModule(ClientConfig.getAppModule("GhostSpaceAdvanceSkill"),"正在打开...",826);
                           }
                           else
                           {
                              SocketConnection.send(CommandID.EXIT_GHOST_SPACE);
                           }
                        });
                     }]);
                  });
               }]);
            }]);
         });
      }
      
      private function onFishClick(param1:MouseEvent) : void
      {
         SocketConnection.send(CommandID.CHALLENGE_GHOST,this._index + 1);
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         SocketConnection.send(CommandID.CHALLENGE_GHOST,1);
      }
      
      private function onBagClick(param1:MouseEvent) : void
      {
         FightPetBagController.show();
      }
      
      private function onExitClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         Alert.show("再次进入时需要重新挑战，确定要离开伏魔空间吗？",function():void
         {
            SocketConnection.send(CommandID.EXIT_GHOST_SPACE);
         });
      }
      
      private function onExitGhostSpace(param1:SocketEvent) : void
      {
         _pro = 0;
         _door_0 = [0,0,0,0,0,0,0,0];
         _door_1 = [0,0,0];
         PetFightModel.type = 0;
         MapManager.changeMap(14);
      }
      
      private function onFightComplete(param1:PetFightEvent) : void
      {
         var e:PetFightEvent = param1;
         var info:FightOverInfo = e.dataObj as FightOverInfo;
         if(info.winnerID == MainManager.actorID)
         {
            if(_pro == 1)
            {
               this.startPro_1();
            }
            else if(_pro == 2)
            {
               this.continuePro_2();
            }
            else if(_pro == 3)
            {
               this.startPro_3();
            }
            else if(_pro == 4)
            {
               this.continuePro_4();
            }
         }
         else
         {
            Alarm.show("非常可惜，你被打败了！",function():void
            {
               SocketConnection.send(CommandID.EXIT_GHOST_SPACE);
            });
         }
      }
      
      private function getRandomDoor(param1:Array) : int
      {
         var _loc2_:int = 0;
         do
         {
            _loc2_ = int(Math.random() * param1.length);
         }
         while(param1[_loc2_] != 0);
         
         param1[_loc2_] = 1;
         return _loc2_;
      }
      
      private function getIsClear(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_] == 0)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      private function get newStart_targetMc() : MovieClip
      {
         return conLevel["storyMC"] as MovieClip;
      }
      
      override public function destroy() : void
      {
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         ToolTipManager.remove(topLevel["bag"]);
         topLevel["bag"].removeEventListener(MouseEvent.CLICK,this.onBagClick);
         ToolTipManager.remove(topLevel["exit"]);
         topLevel["exit"].removeEventListener(MouseEvent.CLICK,this.onExitClick);
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightComplete);
         SocketConnection.removeCmdListener(CommandID.EXIT_GHOST_SPACE,this.onExitGhostSpace);
         conLevel["pet_0"].removeEventListener(MouseEvent.CLICK,this.onFishClick);
         conLevel["pet_1"].removeEventListener(MouseEvent.CLICK,this.onFishClick);
         ToolTipManager.remove(conLevel["boss"]);
         conLevel["boss"].removeEventListener(MouseEvent.CLICK,this.onBossClick);
      }
   }
}

