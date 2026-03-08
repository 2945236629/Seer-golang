package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.utils.CommonUI;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import org.taomee.manager.EventManager;
   
   public class MapProcess_11739 extends BaseMapProcess
   {
      
      private var curnpc:*;
      
      private var lefttime:int;
      
      private var step:int;
      
      private var num:int;
      
      private var timeStamp:int;
      
      private var colefttime:int;
      
      private var coindex:int;
      
      private var upnum:int;
      
      private var time:int;
      
      private var _need:int;
      
      public function MapProcess_11739()
      {
         super();
      }
      
      override protected function init() : void
      {
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         conLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         EventManager.addEventListener("HarvestDaymatchTipPanelClose",this.update);
         SystemTimerManager.addTickFun(this.timerHandle);
         SystemTimerManager.addTickFun(this.colHandle);
         this.update();
      }
      
      private function update(param1:* = null) : void
      {
         var e:* = param1;
         LevelManager.closeMouseEvent();
         KTool.getMultiValue([14614,106110,106111,106112,106113,106114,106115,106121],function(param1:Array):void
         {
            var i:int;
            var state:int = 0;
            var tmp:int = 0;
            var arr:Array = param1;
            step = arr[1];
            time = arr[0];
            (conLevel as MovieClip).gotoAndStop(step < 3 ? 1 : 2);
            (btnLevel as MovieClip).gotoAndStop(step < 3 ? 1 : 2);
            i = 0;
            while(i < 5)
            {
               if(btnLevel["pro_" + i])
               {
                  btnLevel["pro_" + i].visible = false;
               }
               i++;
            }
            setTimeout(function():void
            {
               var i:int;
               (conLevel as MovieClip).gotoAndStop(step < 3 ? 1 : 2);
               (btnLevel as MovieClip).gotoAndStop(step < 3 ? 1 : 2);
               i = 1;
               while(i < 6)
               {
                  if(step < 3)
                  {
                     state = arr[4];
                     if(btnLevel["pro_" + i])
                     {
                        btnLevel["pro_" + i].visible = false;
                     }
                     if(conLevel["npc" + i])
                     {
                        conLevel["npc" + i].visible = KTool.getBit(state,i) == 0;
                        if(step == 0 && time >= 2)
                        {
                           conLevel["npc" + i].visible = false;
                        }
                        CommonUI.setEnabled(conLevel["npc" + i],step > 1,false);
                     }
                     if(KTool.getBit(state,i) == 1)
                     {
                        ++tmp;
                     }
                  }
                  else
                  {
                     state = arr[6];
                     conLevel["boss" + i].visible = KTool.getBit(state,i) == 0 && step != 3;
                     CommonUI.setEnabled(conLevel["boss" + i],step == 5,false);
                     if(KTool.getBit(state,i) == 1)
                     {
                        ++tmp;
                     }
                  }
                  i++;
               }
               if(step < 3)
               {
                  state = arr[4];
                  timeStamp = arr[2];
                  lefttime = 30 * 60 - (SystemTimerManager.time - timeStamp);
                  if(lefttime > 0)
                  {
                     ++lefttime;
                  }
                  conLevel["flag"].visible = step < 2;
                  conLevel["mc"].visible = false && time < 2;
                  conLevel["mc1"].visible = step == 2;
                  upnum = state >> 8 & 0xFF;
                  num = tmp - upnum;
                  btnLevel["tip"].gotoAndStop(step < 2 ? 1 : 2);
                  _need = 5 - upnum;
                  setTimeout(function():void
                  {
                     if(btnLevel["tip"]["txt"])
                     {
                        btnLevel["tip"]["txt"].text = "";
                        (btnLevel["tip"]["txt"] as TextField).htmlText = "<font color=\'#333333\'>请将收集好的麦草交给我！再收集</font><font color=\'#FF0000\'>" + _need + "</font><font color=\'#333333\'>捆就行啦！</font>";
                     }
                  },100);
                  if(step == 0 && time >= 2)
                  {
                     conLevel["flag"].visible = false;
                     conLevel["mc1"].visible = false;
                     btnLevel["tip"].visible = false;
                  }
               }
               else
               {
                  state = arr[6];
                  timeStamp = arr[5];
                  lefttime = 30 * 60 - (SystemTimerManager.time - timeStamp) - arr[3];
                  if(lefttime > 0)
                  {
                     ++lefttime;
                  }
                  conLevel["flag"].visible = step < 5 && step != 3;
                  conLevel["mc"].visible = false;
                  conLevel["mc1"].visible = step == 5;
                  upnum = state >> 8 & 0xFF;
                  num = tmp - upnum;
                  btnLevel["tip"].gotoAndStop(step < 6 ? 1 : 2);
                  btnLevel["tip"].visible = step != 3;
                  _need = 5 - upnum;
                  setTimeout(function():void
                  {
                     if(btnLevel["tip"]["txt"])
                     {
                        btnLevel["tip"]["txt"].text = "";
                        (btnLevel["tip"]["txt"] as TextField).htmlText = "<font color=\'#333333\'>加油！再提交</font><font color=\'#FF0000\'>" + _need + "</font><font color=\'#333333\'>捆麦草，你的任务就完成了！</font>";
                     }
                     if((btnLevel["tip"] as MovieClip).currentFrame == 2)
                     {
                        if(btnLevel["tip"]["txt"])
                        {
                           btnLevel["tip"]["txt"].text = "谢谢你，勤劳的" + MainManager.actorInfo.nick + "！你是我们麦田村的恩人！";
                        }
                     }
                  },100);
               }
               timerHandle();
               LevelManager.openMouseEvent();
            },100);
         });
      }
      
      private function timerHandle() : void
      {
         if(this.lefttime > 0)
         {
            --this.lefttime;
            if(conLevel["mc1"])
            {
               conLevel["mc1"]["txt"].text = SystemTimerManager.getTimeClockString(this.lefttime,false);
            }
            if(this.lefttime <= 0)
            {
               if(this.step == 6)
               {
                  return;
               }
               SocketConnection.sendByQueue(45745,[25,2],function(param1:*):void
               {
                  update();
               },function(param1:*):void
               {
                  update();
               });
            }
         }
         else if(this.timeStamp != 0)
         {
            if(this.step == 6)
            {
               return;
            }
            SocketConnection.sendByQueue(45745,[25,2],function(param1:*):void
            {
               update();
            });
         }
      }
      
      private function colHandle() : void
      {
         if(this.colefttime > 0)
         {
            --this.colefttime;
            btnLevel["pro_" + this.coindex]["pro"].gotoAndStop(int(btnLevel["pro_" + this.coindex]["pro"].totalFrames * Number((5 - this.colefttime) / 5)) + 1);
            if(this.colefttime <= 0)
            {
               LevelManager.openMouseEvent();
               btnLevel["pro_" + this.coindex].visible = false;
               SocketConnection.sendByQueue(45745,[22,this.coindex],function(param1:*):void
               {
                  update();
               });
            }
         }
      }
      
      private function npcClick(param1:MouseEvent) : void
      {
         this.curnpc = param1.target;
         MainManager.actorModel.stop();
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         var _loc2_:Point = new Point();
         _loc2_ = MainManager.actorModel.parent.globalToLocal(this.curnpc.localToGlobal(new Point(0,0)));
         MainManager.actorModel.walkAction(_loc2_,false);
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
      }
      
      private function onWalkEnter(param1:RobotEvent) : void
      {
         var point:Point = null;
         var evt:RobotEvent = param1;
         if(Boolean(MainManager.actorModel.parent) && this.curnpc)
         {
            point = new Point();
            point = MainManager.actorModel.parent.globalToLocal(this.curnpc.localToGlobal(new Point(0,0)));
            if(this.curnpc && Point.distance(point,MainManager.actorModel.pos) < 60)
            {
               MainManager.actorModel.stop();
               switch(this.curnpc)
               {
                  case conLevel["npc1"]:
                  case conLevel["npc2"]:
                  case conLevel["npc3"]:
                  case conLevel["npc4"]:
                  case conLevel["npc5"]:
                     if(this.step == 2)
                     {
                        LevelManager.closeMouseEvent();
                        this.coindex = parseInt((this.curnpc.name as String).substr(3,1));
                        btnLevel["pro_" + this.coindex].visible = true;
                        this.colefttime = 6;
                        this.colHandle();
                     }
                     break;
                  case conLevel["boss1"]:
                  case conLevel["boss2"]:
                  case conLevel["boss3"]:
                  case conLevel["boss4"]:
                  case conLevel["boss5"]:
                     if(this.step == 5)
                     {
                        this.coindex = parseInt((this.curnpc.name as String).substr(4,1));
                        FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
                        {
                           FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
                        });
                        FightManager.fightNoMapBoss("",14347 + this.coindex - 1);
                     }
                     break;
                  case conLevel["maigugu"]:
                     if(this.step == 0)
                     {
                        if(this.time < 2)
                        {
                           NpcDialog.show(1145,["麦田丰收了，我们需要一些好心人帮忙，将田里散落的麦子捡回来。这便是丰收大赛的第一阶段考验，你愿意帮忙吗？"],["我愿意！","晚些再说。"],[function():void
                           {
                              SocketConnection.sendByQueue(45745,[21,1],function(param1:*):void
                              {
                                 var e:* = param1;
                                 StatManager.sendStat2014("1019丰收节收获比赛","开始丰收大赛第一阶段","2018运营活动");
                                 conLevel["mc"].visible = true;
                                 LevelManager.closeMouseEvent();
                                 AnimateManager.playMcAnimate(conLevel["mc"],1,"",function():void
                                 {
                                    LevelManager.openMouseEvent();
                                    SocketConnection.sendByQueue(45745,[21,2],function(param1:*):void
                                    {
                                       update();
                                    });
                                 });
                              });
                           },function():void
                           {
                           }],false,null,true);
                           break;
                        }
                        NpcDialog.show(1145,["今天的丰收大赛暂告一段落，明天再来参与吧！"],["知道啦！"],[function():void
                        {
                        }],false,null,true);
                        break;
                     }
                     if(this.step == 2)
                     {
                        if(this.num > 0)
                        {
                           SocketConnection.sendByQueue(45745,[23,0],function(param1:*):void
                           {
                              var e:* = param1;
                              Alarm.show("向麦古古递交了" + num + "捆麦草");
                              if(num + upnum >= 5)
                              {
                                 NpcDialog.show(1145,["很好！很好！你的速度超出了我的预料，非常感谢你的帮忙！"],["不客气！"],[function():void
                                 {
                                    update();
                                    showdialog();
                                 }],false,null,true);
                              }
                              else
                              {
                                 update();
                              }
                           });
                        }
                        break;
                     }
                     if(this.step == 3)
                     {
                        this.showdialog();
                        break;
                     }
                     if(this.step == 4)
                     {
                        conLevel["mc"].visible = true;
                        LevelManager.closeMouseEvent();
                        AnimateManager.playMcAnimate(conLevel["mc"],1,"",function():void
                        {
                           LevelManager.openMouseEvent();
                           SocketConnection.sendByQueue(45745,[24,2],function(param1:*):void
                           {
                              update();
                           });
                        });
                        break;
                     }
                     if(this.step == 5)
                     {
                        if(this.num > 0)
                        {
                           SocketConnection.sendByQueue(45745,[23,0],function(param1:*):void
                           {
                              var e:* = param1;
                              Alarm.show("向麦古古递交了" + num + "捆麦草");
                              if(num + upnum >= 5)
                              {
                                 NpcDialog.show(1145,["你真是太英勇了，我的勇士！非常感谢你为麦田村所做的一切，快去领取你的奖励吧！"],["不客气！"],[function():void
                                 {
                                    ModuleManager.showAppModule("HarvestDaymatchTipPanel");
                                    update();
                                 }],false,null,true);
                              }
                              else
                              {
                                 update();
                              }
                           });
                        }
                        break;
                     }
                     if(this.step == 6)
                     {
                        NpcDialog.show(1145,["你真是太英勇了，我的勇士！非常感谢你为麦田村所做的一切，快去领取你的奖励吧！"],["不客气！"],[function():void
                        {
                           ModuleManager.showAppModule("HarvestDaymatchTipPanel");
                           update();
                        }],false,null,true);
                     }
               }
               this.curnpc = null;
            }
         }
      }
      
      private function showdialog() : void
      {
         NpcDialog.show(1145,["除此以外，还有一件事情希望能够得到你的帮助！"],["什么事？"],[function():void
         {
            NpcDialog.show(1145,["有一些讨厌的家伙抢走了属于我们的粮食，我请求你帮帮忙，给他们一点教训，并把这些粮食抢回来！这便是丰收大赛的第二阶段考验，你愿意帮忙吗？"],["我愿意！","晚些再说。"],[function():void
            {
               SocketConnection.sendByQueue(45745,[24,1],function(param1:*):void
               {
                  var e:* = param1;
                  StatManager.sendStat2014("1019丰收节收获比赛","开始丰收大赛第二阶段","2018运营活动");
                  conLevel["mc"].visible = true;
                  LevelManager.closeMouseEvent();
                  AnimateManager.playMcAnimate(conLevel["mc"],1,"",function():void
                  {
                     LevelManager.openMouseEvent();
                     SocketConnection.sendByQueue(45745,[24,2],function(param1:*):void
                     {
                        update();
                     });
                  });
               });
            },function():void
            {
            }],false,null,true);
         }],false,null,true);
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         switch(_loc2_)
         {
            case "close":
               MapManager.changeMap(1317);
               break;
            default:
               if(param1.target is SimpleButton)
               {
                  this.npcClick(param1);
               }
         }
      }
      
      override public function destroy() : void
      {
         EventManager.removeEventListener("HarvestDaymatchTipPanelClose",this.update);
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         SystemTimerManager.removeTickFun(this.colHandle);
         SystemTimerManager.removeTickFun(this.timerHandle);
         conLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         super.destroy();
      }
   }
}

