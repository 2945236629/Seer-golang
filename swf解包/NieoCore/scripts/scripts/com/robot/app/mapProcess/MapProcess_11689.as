package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.utils.CommonUI;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import flash.utils.setTimeout;
   
   public class MapProcess_11689 extends BaseMapProcess
   {
      
      private static var fightshow:Boolean;
      
      private var curnpc:*;
      
      private var isday:Boolean;
      
      private var intask:Boolean;
      
      private var daytaskpro:int;
      
      private var nighttask1pro:int;
      
      private var nighttask2pro:int;
      
      private var nighttask3pro:int;
      
      private var nighttask4pro:int;
      
      private var nighttask3lefttime:int;
      
      private var nighttask3time:int;
      
      private var nighttask4lefttime:int;
      
      private var nighttask4time:int;
      
      private const keycodes:Array = [Keyboard.Q,Keyboard.W,Keyboard.E,Keyboard.R,Keyboard.A,Keyboard.S,Keyboard.D];
      
      private var showtipidx:int;
      
      private var daytasktwoover:Boolean;
      
      private var branchState:int;
      
      private var huoyuedu:int;
      
      private var huopenstate:int;
      
      private var huopen1intask:Boolean;
      
      private var huopen2intask:Boolean;
      
      private var huopen3intask:Boolean;
      
      private var task1state:int;
      
      private var brachintask1:Boolean;
      
      private var brachintask2:Boolean;
      
      private var brachintask3:Boolean;
      
      private var brachintask4:Boolean;
      
      private var brachintask5:Boolean;
      
      private var task2state:int;
      
      private var key:int;
      
      private var overflow:Boolean = false;
      
      private var keys:Array;
      
      private var index:int;
      
      private var huopennum:int;
      
      private var huopentasking:Boolean;
      
      private var huopentaskover:Boolean;
      
      private var branchnum:int;
      
      public function MapProcess_11689()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         topLevel["panel"].visible = false;
         topLevel["panel2"].visible = false;
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            topLevel["panel2"]["cell_" + _loc1_].gotoAndStop(1);
            _loc1_++;
         }
         topLevel["mc"].mouseChildren = topLevel["mc"].mouseEnabled = false;
         topLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         conLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         SystemTimerManager.addTickFun(this.timerHandle);
         var _loc2_:Date = SystemTimerManager.sysBJDate;
         if(_loc2_.hours >= 6 && _loc2_.hours < 18)
         {
            this.isday = true;
            this.showday();
         }
         else
         {
            this.isday = false;
            this.shownight();
         }
         this.refreshstate();
      }
      
      private function refreshstate(param1:Function = null) : void
      {
         var fun:Function = param1;
         LevelManager.closeMouseEvent();
         KTool.getMultiValue([16880,16881,104453,16882,16883,16886],function(param1:Array):void
         {
            var _loc3_:int = 0;
            var _loc4_:* = false;
            var _loc5_:* = false;
            var _loc6_:* = false;
            key = param1[4];
            huoyuedu = param1[2];
            keys = [];
            var _loc2_:int = 0;
            while(_loc2_ < 7)
            {
               keys.push(keycodes[(param1[4] >> _loc2_ * 4 & 0x0F) - 1]);
               _loc2_++;
            }
            task1state = param1[0];
            task2state = param1[1];
            daytaskpro = task1state & 0x0F;
            branchState = task1state >> 11 & 0x1F;
            intask = KTool.getBit(task1state,10) == 1 && daytaskpro == 0 || KTool.getBit(task1state,11) == 1 && daytaskpro == 1;
            daytasktwoover = false;
            huopenstate = param1[1];
            if(intask)
            {
               if(daytaskpro == 0)
               {
                  showtipidx = 2;
               }
               else
               {
                  daytasktwoover = (param1[1] & 7) == 7;
                  showtipidx = 4;
               }
            }
            LevelManager.openMouseEvent();
            branchnum = 0;
            huopennum = 0;
            nighttask1pro = (param1[3] & 0x0F) + KTool.getBit(param1[5],1);
            nighttask2pro = (param1[3] >> 4 & 0x0F) + KTool.getBit(param1[5],2);
            nighttask3pro = (param1[3] >> 8 & 0x0F) + KTool.getBit(param1[5],3);
            nighttask4pro = (param1[3] >> 12 & 0x0F) + KTool.getBit(param1[5],4);
            if(isday)
            {
               _loc3_ = 0;
               while(_loc3_ < 5)
               {
                  conLevel["branch" + (_loc3_ + 1)].visible = KTool.getBit(task1state,5 + _loc3_) == 0;
                  conLevel["branch" + (_loc3_ + 1) + "_arrow"].visible = KTool.getBit(task1state,5 + _loc3_) == 0 && intask && daytaskpro == 0;
                  if(_loc3_ < 3)
                  {
                     if(KTool.getBit(param1[1],_loc3_ + 1) == 1)
                     {
                        ++huopennum;
                     }
                  }
                  if(KTool.getBit(task1state,5 + _loc3_) == 1)
                  {
                     ++branchnum;
                  }
                  this["brachintask" + (_loc3_ + 1)] = KTool.getBit(task1state,5 + _loc3_) == 0 && KTool.getBit(task1state,12 + _loc3_) > 0;
                  _loc3_++;
               }
               CommonUI.setEnabled(conLevel["branch1"],intask && daytaskpro == 0 && !brachintask2 && !brachintask3 && !brachintask4 && !brachintask5,false);
               CommonUI.setEnabled(conLevel["branch2"],intask && daytaskpro == 0 && !brachintask1 && !brachintask3 && !brachintask4 && !brachintask5,false);
               CommonUI.setEnabled(conLevel["branch3"],intask && daytaskpro == 0 && !brachintask2 && !brachintask1 && !brachintask4 && !brachintask5,false);
               CommonUI.setEnabled(conLevel["branch4"],intask && daytaskpro == 0 && !brachintask2 && !brachintask3 && !brachintask1 && !brachintask5,false);
               CommonUI.setEnabled(conLevel["branch5"],intask && daytaskpro == 0 && !brachintask2 && !brachintask3 && !brachintask4 && !brachintask1,false);
               _loc4_ = KTool.getBit(param1[1],1) == 1;
               _loc5_ = KTool.getBit(param1[1],2) == 1;
               _loc6_ = KTool.getBit(param1[1],3) == 1;
               huopen1intask = !_loc4_ && (param1[1] >> 4 & 0x0F) > 0;
               huopen2intask = !_loc5_ && (param1[1] >> 8 & 0x0F) > 0;
               huopen3intask = !_loc6_ && (param1[1] >> 12 & 0x0F) > 0;
               conLevel["huopen_0"].gotoAndStop(_loc4_ ? 3 : (intask && daytaskpro == 1 && !huopen2intask && !huopen3intask && (param1[1] >> 4 & 0x0F) != 1 ? 2 : 1));
               conLevel["huopen_1"].gotoAndStop(_loc5_ ? 3 : (intask && daytaskpro == 1 && !huopen1intask && !huopen3intask && (param1[1] >> 8 & 0x0F) != 1 ? 2 : 1));
               conLevel["huopen_2"].gotoAndStop(_loc6_ ? 3 : (intask && daytaskpro == 1 && !huopen1intask && !huopen2intask && (param1[1] >> 12 & 0x0F) != 1 ? 2 : 1));
               CommonUI.setEnabled(conLevel["branchStack"],intask && daytaskpro == 0 && branchnum >= 5,false);
               CommonUI.setEnabled(conLevel["box"],!_loc4_ && (param1[1] >> 4 & 0x0F) == 1 || !_loc5_ && (param1[1] >> 8 & 0x0F) == 1 || !_loc6_ && (param1[1] >> 12 & 0x0F) == 1,false);
               if(fightshow && daytaskpro == 0 && intask)
               {
                  branchget();
                  fightshow = false;
               }
               conLevel["huopen_0_arrow"].visible = intask && daytaskpro == 1 && !huopen2intask && !huopen3intask && (param1[1] >> 4 & 0x0F) != 1 && !_loc4_;
               conLevel["huopen_1_arrow"].visible = intask && daytaskpro == 1 && !huopen1intask && !huopen3intask && (param1[1] >> 8 & 0x0F) != 1 && !_loc5_;
               conLevel["huopen_2_arrow"].visible = intask && daytaskpro == 1 && !huopen1intask && !huopen2intask && (param1[1] >> 12 & 0x0F) != 1 && !_loc6_;
               conLevel["branchStack_arrow"].visible = intask && daytaskpro == 0 && branchnum >= 5;
               conLevel["box_arrow"].visible = !_loc4_ && (param1[1] >> 4 & 0x0F) == 1 || !_loc5_ && (param1[1] >> 8 & 0x0F) == 1 || !_loc6_ && (param1[1] >> 12 & 0x0F) == 1;
            }
            else
            {
               CommonUI.setEnabled(conLevel["banlieni"],nighttask1pro == 0 || nighttask1pro == 2,false);
               CommonUI.setEnabled(conLevel["jimiliya"],nighttask1pro == 0 || nighttask1pro == 2,false);
               CommonUI.setEnabled(conLevel["nujiadasi"],nighttask1pro == 1,false);
               CommonUI.setEnabled(conLevel["faluote"],nighttask2pro == 0 || nighttask2pro == 3,false);
               CommonUI.setEnabled(conLevel["huobaoshu"],nighttask2pro == 1 || nighttask2pro == 2,false);
               CommonUI.setEnabled(conLevel["mengtena"],nighttask3pro == 0 || nighttask3pro == 1,false);
               CommonUI.setEnabled(conLevel["singer"],nighttask4pro == 0 || nighttask4pro == 1,false);
               CommonUI.setEnabled(conLevel["singer1"],nighttask4pro == 0 || nighttask4pro == 1,false);
               conLevel["banlieni_arrow"].visible = nighttask1pro == 2;
               conLevel["jimiliya_arrow"].visible = nighttask1pro == 2;
               conLevel["nujiadasi_arrow"].visible = nighttask1pro == 1;
               conLevel["faluote_arrow"].visible = nighttask2pro == 3;
               conLevel["huobaoshu_arrow"].visible = nighttask2pro == 1 || nighttask2pro == 2;
               conLevel["mengtena_arrow"].visible = nighttask3pro == 1;
               conLevel["singer_arrow"].visible = nighttask4pro == 1;
               conLevel["singer1_arrow"].visible = nighttask4pro == 1;
            }
            if(fun != null)
            {
               fun();
            }
         });
      }
      
      private function timerHandle() : void
      {
         var _loc1_:Date = SystemTimerManager.sysBJDate;
         if(_loc1_.hours >= 6 && _loc1_.hours < 18)
         {
            if(!this.isday)
            {
               this.isday = true;
               this.showday();
               this.refreshstate();
            }
         }
         else
         {
            if(this.isday)
            {
               this.isday = false;
               this.shownight();
               this.refreshstate();
            }
            if(this.nighttask3lefttime > 0)
            {
               --this.nighttask3lefttime;
               if(this.nighttask3lefttime <= 0)
               {
                  this.fivesecondover();
               }
            }
            if(this.nighttask4lefttime > 0)
            {
               --this.nighttask4lefttime;
               KTool.showScore(topLevel["panel2"]["num"],this.nighttask4lefttime);
               if(this.nighttask4lefttime <= 0)
               {
                  this.task4timeover();
               }
            }
         }
      }
      
      private function showday() : void
      {
         StatManager.sendStat2014("0727仲夏火焰节主题活动","白天进入活动场景","2018运营活动");
         (conLevel as MovieClip).gotoAndStop(1);
         topLevel["mc"].gotoAndStop(1);
      }
      
      private function shownight() : void
      {
         StatManager.sendStat2014("0727仲夏火焰节主题活动","夜晚进入活动场景","2018运营活动");
         (conLevel as MovieClip).gotoAndStop(2);
         topLevel["mc"].gotoAndStop(2);
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
         this.refreshstate();
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         switch(_loc2_)
         {
            case "ok":
               topLevel["panel"].visible = false;
               break;
            case "bag":
               PetBagControllerNew.showByBuffer();
               break;
            case "cure":
               PetManager.cureAllFree();
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
         topLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         LevelManager.iconLevel.visible = true;
         this.keys = null;
         if(LevelManager.stage.hasEventListener(KeyboardEvent.KEY_UP))
         {
            LevelManager.stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyupHandle);
         }
         LevelManager.root.removeEventListener(MouseEvent.CLICK,this.levelrootClick);
         MainManager.actorModel.removeEventListener("SEER_SQUAT",this.squatHandle);
         LevelManager.iconLevel.visible = true;
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         SystemTimerManager.removeTickFun(this.timerHandle);
         conLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         super.destroy();
      }
      
      private function npc1Handle() : void
      {
         if(this.intask)
         {
            if(this.daytasktwoover)
            {
               NpcDialog.show(NPC.SEER,["呼，好累！终于全点着了！"],null,null,false,function():void
               {
                  NpcDialog.show(4660,["谢谢你！这样，我就可以更快地完成今晚篝火节的准备工作了！"],["不客气！"],[function():void
                  {
                     SocketConnection.sendByQueue(43299,[2,10],function(param1:*):void
                     {
                        showpanel(1);
                        refreshstate();
                     });
                  }],false,null,true);
               });
            }
            else
            {
               NpcDialog.show(4660,["快帮帮我吧，我要来不及准备了！"],["我这就去！"],[function():void
               {
                  showpanel(showtipidx);
               }],false,null,true);
            }
         }
         else if(this.daytaskpro >= 2)
         {
            NpcDialog.show(4660,["篝火晚会将于18:00开启，听说会有很多绝版的精灵前来狂欢！如果你想获得它们，届时一定要来参加哦！"],["我一定会来的！"],[function():void
            {
            }],false,null,true);
         }
         else
         {
            NpcDialog.show(4660,["篝火晚会将于18:00开启，听说会有很多绝版的精灵前来狂欢哦！我还有一些准备工作没有做好，你愿意帮帮我吗？这将让你更快地获得它们！"],["放着我来","我还有别的事情要忙。"],[function():void
            {
               if(daytaskpro == 0)
               {
                  NpcDialog.show(4660,["篝火晚会需要用到大量的木材，为了防止滥砍滥伐，我们一年只会举行一次！你能否帮我去后面的小树林里再弄一些木材过来？"],["当然没问题！"],[function():void
                  {
                     StatManager.sendStat2014("0727仲夏火焰节主题活动","接取任务1","2018运营活动");
                     SocketConnection.sendByQueue(43299,[1,7],function(param1:*):void
                     {
                        refreshstate();
                        showpanel(2);
                     });
                  }],false,null,true);
               }
               else
               {
                  NpcDialog.show(4660,["想要营造出篝火晚会的氛围，不仅要有一团大篝火，还要有很多小篝火来衬托才行！天色将晚，这里的海边有很多火盆，你能帮我把它们全部点燃吗？"],["当然没问题！"],[function():void
                  {
                     StatManager.sendStat2014("0727仲夏火焰节主题活动","接取任务2","2018运营活动");
                     SocketConnection.sendByQueue(43299,[2,11],function(param1:*):void
                     {
                        refreshstate();
                        showpanel(4);
                     });
                  }],false,null,true);
               }
            },null],false,null,true);
         }
      }
      
      private function showpanel(param1:int) : void
      {
         var old:int = 0;
         var idx:int = param1;
         topLevel["panel"]["mc"].gotoAndStop(idx);
         topLevel["panel"].visible = true;
         old = this.huoyuedu;
         if(idx == 1)
         {
            setTimeout(function():void
            {
               KTool.getMultiValue([104453],function(param1:Array):void
               {
                  if(topLevel && topLevel["panel"] && Boolean(topLevel["panel"]["mc"]["txt"]))
                  {
                     topLevel["panel"]["mc"]["txt"].text = "你获得了" + (param1[0] - old) + "点篝火节活跃度，当前累计拥有" + param1[0] + "点！篝火节活跃度可用于兑换绝版精灵哦！";
                  }
               });
            },100);
         }
      }
      
      private function onWalkEnter(param1:RobotEvent) : void
      {
         var _loc2_:Point = new Point();
         _loc2_ = MainManager.actorModel.parent.globalToLocal(this.curnpc.localToGlobal(new Point(0,0)));
         if(this.curnpc && Point.distance(_loc2_,MainManager.actorModel.pos) < 60)
         {
            MainManager.actorModel.stop();
            MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
            if(Boolean(this.curnpc.visible) && this.isday)
            {
               switch(this.curnpc)
               {
                  case conLevel["npc1"]:
                     if(this.isday)
                     {
                        this.npc1Handle();
                        break;
                     }
                     ModuleManager.showAppModule("FireFestivalselectpetPanel");
                     break;
                  case conLevel["branch1"]:
                  case conLevel["branch2"]:
                  case conLevel["branch3"]:
                  case conLevel["branch4"]:
                  case conLevel["branch5"]:
                     this.branchHandle(this.curnpc.name);
                     break;
                  case conLevel["branchStack"]:
                     this.branchStackHandle();
                     break;
                  case conLevel["huopen_0"]["burn"]:
                  case conLevel["huopen_1"]["burn"]:
                  case conLevel["huopen_2"]["burn"]:
                     this.huopenHandle(this.curnpc.parent.name);
                     break;
                  case conLevel["box"]:
                     this.boxHandle();
               }
            }
            else if(Boolean(this.curnpc.visible) && !this.isday)
            {
               switch(this.curnpc)
               {
                  case conLevel["npc1"]:
                     if(this.isday)
                     {
                        this.npc1Handle();
                        break;
                     }
                     ModuleManager.showAppModule("FireFestivalselectpetPanel");
                     break;
                  case conLevel["banlieni"]:
                  case conLevel["jimiliya"]:
                     this.nightTaskHandle1();
                     break;
                  case conLevel["nujiadasi"]:
                     this.nujiadasiHandle();
                     break;
                  case conLevel["faluote"]:
                     this.nightTaskHandle2();
                     break;
                  case conLevel["huobaoshu"]:
                     this.huobaoshuHandle();
                     break;
                  case conLevel["mengtena"]:
                     this.nightTaskHandle3();
                     break;
                  case conLevel["singer"]:
                  case conLevel["singer1"]:
                     this.nightTaskHandle4();
               }
            }
            this.curnpc = null;
         }
      }
      
      private function task4timeover() : void
      {
         this.wrong();
      }
      
      private function right() : void
      {
         ++this.nighttask4time;
         this.nighttask4lefttime = 0;
         if(this.nighttask4time >= 4)
         {
            this.nighttask4over();
         }
         else
         {
            SocketConnection.sendByQueue(43299,[6,2],function(param1:*):void
            {
               var e:* = param1;
               refreshstate(function():void
               {
                  play();
               });
            });
         }
      }
      
      private function keyupHandle(param1:KeyboardEvent) : void
      {
         var e:KeyboardEvent = param1;
         if(this.nighttask4lefttime > 0)
         {
            if(e.keyCode == this.keys[this.index])
            {
               topLevel["panel2"]["cell_" + this.index]["mc"].gotoAndStop(2);
               ++this.index;
               if(this.index >= 7)
               {
                  this.right();
               }
            }
            else
            {
               StatManager.sendStat2014("0727仲夏火焰节主题活动","唱歌按键出错","2018运营活动");
               topLevel["panel2"]["cell_" + this.index]["mc"].gotoAndStop(3);
               LevelManager.stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyupHandle);
               LevelManager.closeMouseEvent();
               setTimeout(function():void
               {
                  LevelManager.stage.addEventListener(KeyboardEvent.KEY_UP,keyupHandle);
                  LevelManager.openMouseEvent();
                  index = 0;
                  var _loc1_:int = 0;
                  while(_loc1_ < 7)
                  {
                     topLevel["panel2"]["cell_" + _loc1_]["mc"].gotoAndStop(1);
                     _loc1_++;
                  }
               },1000);
            }
         }
      }
      
      private function wrong() : void
      {
         this.nighttask4time = 0;
         this.nighttask4lefttime = 0;
         this.nighttask4notover();
         topLevel["panel2"].visible = false;
      }
      
      private function play() : void
      {
         var i:int;
         topLevel["panel2"].visible = true;
         LevelManager.stage.focus = topLevel["panel2"];
         i = 0;
         while(i < 7)
         {
            topLevel["panel2"]["cell_" + i].gotoAndStop(this.key >> i * 4 & 0x0F);
            i++;
         }
         setTimeout(function():void
         {
            var _loc1_:int = 0;
            while(_loc1_ < 7)
            {
               topLevel["panel2"]["cell_" + _loc1_]["mc"].gotoAndStop(1);
               _loc1_++;
            }
            LevelManager.stage.focus = topLevel["panel2"];
            index = 0;
            nighttask4lefttime = 10;
            KTool.showScore(topLevel["panel2"]["num"],nighttask4lefttime);
            LevelManager.stage.removeEventListener(KeyboardEvent.KEY_UP,keyupHandle);
            LevelManager.stage.addEventListener(KeyboardEvent.KEY_UP,keyupHandle);
         },100);
      }
      
      private function nighttask4over() : void
      {
         SocketConnection.sendByQueue(43299,[6,3],function(param1:*):void
         {
            var e:* = param1;
            NpcDialog.show(NPC.SEER,["晚风吹过温暖我心底~我又想起你~"],["哇，唱的真好！"],[function():void
            {
               topLevel["panel2"].visible = false;
               NpcDialog.show(923,["终于又碰到一个歌喉美妙的朋友了！我很喜欢你的声音，小朋友。你愿不愿意加入我们？"],["当然愿意啦！"],[function():void
               {
                  showpanel(1);
                  refreshstate();
               }],false,null,true);
            }]);
         });
      }
      
      private function nighttask4notover() : void
      {
         NpcDialog.show(992,["谁呀谁呀！唱的这么难听！能不能好好练一练音律，再来一起唱！"],["不好意思……"],[function():void
         {
         }],false,null,true);
      }
      
      private function nightTaskHandle4() : void
      {
         if(this.nighttask4pro == 0)
         {
            NpcDialog.show(923,["夏天夏天悄悄过去留下小秘密~"],null,null,false,function():void
            {
               NpcDialog.show(992,["压心底压心底不能告诉你~~"],null,null,false,function():void
               {
                  NpcDialog.show(NPC.SEER,["他们唱的好开心，忍不住也想加入！"],null,null,false,function():void
                  {
                     StatManager.sendStat2014("0727仲夏火焰节主题活动","接取唱歌任务","2018运营活动");
                     SocketConnection.sendByQueue(43299,[6,1],function(param1:*):void
                     {
                        var e:* = param1;
                        refreshstate(function():void
                        {
                           nighttask4time = 0;
                           play();
                        });
                     });
                  });
               },true);
            },true);
         }
         else if(this.nighttask4pro == 1)
         {
            NpcDialog.show(923,["夏天夏天悄悄过去留下小秘密~"],null,null,false,function():void
            {
               NpcDialog.show(992,["压心底压心底不能告诉你~~"],null,null,false,function():void
               {
                  NpcDialog.show(NPC.SEER,["他们唱的好开心，忍不住也想加入！"],null,null,false,function():void
                  {
                     nighttask4time = 0;
                     play();
                  });
               },true);
            },true);
         }
      }
      
      private function fivesecondover() : void
      {
         var ran:int;
         var point:Point = null;
         LevelManager.root.removeEventListener(MouseEvent.CLICK,this.levelrootClick);
         ++this.nighttask3time;
         point = new Point();
         ran = Math.round(Math.random());
         if(ran == 0)
         {
            point = new Point(MainManager.actorModel.x + 10,MainManager.actorModel.y);
         }
         else
         {
            point = new Point(MainManager.actorModel.x - 10,MainManager.actorModel.y);
         }
         switch(this.nighttask3time)
         {
            case 1:
               NpcDialog.show(702,["年轻人，有什么感觉吗？"],["我觉得好热！要出汗了！"],[function():void
               {
                  NpcDialog.show(702,["唉。你再坐一会儿。"],null,null,false,function():void
                  {
                     MainManager.actorModel.walkAction(point);
                     MainManager.actorModel.addEventListener("SEER_SQUAT",squatHandle);
                  },true);
               }],false,null,true);
               break;
            case 2:
               NpcDialog.show(702,["年轻人，现在你有什么感觉吗？"],["篝火的燃烧声，远处的唱歌声……好吵！"],[function():void
               {
                  NpcDialog.show(702,["唉。你再坐一会儿。"],null,null,false,function():void
                  {
                     MainManager.actorModel.walkAction(point);
                     MainManager.actorModel.addEventListener("SEER_SQUAT",squatHandle);
                  },true);
               }],false,null,true);
               break;
            case 3:
               NpcDialog.show(702,["年轻人，现在你有什么感觉吗？"],null,null,false,function():void
               {
                  NpcDialog.show(NPC.SEER,["好像不是很热了，吵闹声也不明显了。清凉的晚风吹得我好舒服……"],null,null,false,function():void
                  {
                     NpcDialog.show(702,["我很欣赏你，现在愿意这样静下心来的孩子不多了。学会耐心，学会平和，你会逐渐发现，自然是多么令人陶醉。"],["受教了！"],[function():void
                     {
                        MainManager.actorModel.walkAction(point);
                        SocketConnection.sendByQueue(43299,[5,2],function(param1:*):void
                        {
                           showpanel(1);
                           refreshstate();
                        });
                     }],false,null,true);
                  });
               },true);
         }
      }
      
      private function fivesecondnotover() : void
      {
         StatManager.sendStat2014("0727仲夏火焰节主题活动","打坐中途移动","2018运营活动");
         this.nighttask3lefttime = 0;
         this.nighttask3time = 0;
         LevelManager.root.removeEventListener(MouseEvent.CLICK,this.levelrootClick);
         NpcDialog.show(702,["年轻人，毛毛躁躁的。安静地坐一会儿，你会感受到自然的奇妙。"],null,null,false,function():void
         {
            MainManager.actorModel.addEventListener("SEER_SQUAT",squatHandle);
         },true);
      }
      
      private function squatHandle(param1:Event) : void
      {
         var e:Event = param1;
         MainManager.actorModel.removeEventListener("SEER_SQUAT",this.squatHandle);
         setTimeout(function():void
         {
            LevelManager.root.addEventListener(MouseEvent.CLICK,levelrootClick);
            nighttask3lefttime = 5;
         },100);
      }
      
      private function levelrootClick(param1:MouseEvent) : void
      {
         if(this.nighttask3lefttime > 0)
         {
            this.fivesecondnotover();
         }
         param1.stopImmediatePropagation();
      }
      
      private function nightTaskHandle3() : void
      {
         if(this.nighttask3pro == 0)
         {
            NpcDialog.show(702,["感受这晚风……"],["有什么特别的吗？"],[function():void
            {
               NpcDialog.show(702,["嘘……不要吵，坐下来，用心去体会。"],["这么玄乎？我坐一会儿好了！"],[function():void
               {
                  StatManager.sendStat2014("0727仲夏火焰节主题活动","接取打坐任务","2018运营活动");
                  SocketConnection.sendByQueue(43299,[5,1],function(param1:*):void
                  {
                     refreshstate();
                     showpanel(8);
                     nighttask3time = 0;
                     LevelManager.root.removeEventListener(MouseEvent.CLICK,levelrootClick);
                     MainManager.actorModel.addEventListener("SEER_SQUAT",squatHandle);
                  });
               }],false,null,true);
            }],false,null,true);
         }
         else if(this.nighttask3pro == 1)
         {
            NpcDialog.show(702,["年轻人，毛毛躁躁的。安静地坐一会儿，你会感受到自然的奇妙。"],null,null,false,function():void
            {
               showpanel(8);
               LevelManager.root.removeEventListener(MouseEvent.CLICK,levelrootClick);
               MainManager.actorModel.addEventListener("SEER_SQUAT",squatHandle);
            },true);
         }
      }
      
      private function huobaoshuHandle() : void
      {
         if(this.nighttask2pro == 2)
         {
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
            {
               var e:PetFightEvent = param1;
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
               if(FightManager.isWin)
               {
                  NpcDialog.show(365,["不好意思，起床气有点严重，还好没有伤到你……"],null,null,false,function():void
                  {
                     NpcDialog.show(NPC.SEER,["没事没事，不过你还记得跟法洛特的约定吗？"],null,null,false,function():void
                     {
                        NpcDialog.show(365,["哎呀！糟了糟了，我刚才不小心睡着了，这下可要让他气坏了。小朋友，你快帮我去跟他说一声，我去洗把脸，等下就来！"],["好的！"],[function():void
                        {
                        }],false,null,true);
                     });
                  },true);
               }
            });
            FightManager.fightNoMapBoss("",13604);
         }
         else if(this.nighttask2pro == 1)
         {
            SocketConnection.sendByQueue(43299,[4,2],function(param1:*):void
            {
               var e:* = param1;
               refreshstate(function():void
               {
                  NpcDialog.show(NPC.SEER,["火爆鼠！火爆鼠！醒醒！"],null,null,false,function():void
                  {
                     NpcDialog.show(365,["没看到我在睡觉吗，吵什么吵！不给你点颜色看看，你就不知道本大爷的起床气有多严重！"],["救命！"],[function():void
                     {
                        FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
                        {
                           var e:PetFightEvent = param1;
                           FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
                           if(FightManager.isWin)
                           {
                              NpcDialog.show(365,["不好意思，起床气有点严重，还好没有伤到你……"],null,null,false,function():void
                              {
                                 NpcDialog.show(NPC.SEER,["没事没事，不过你还记得跟法洛特的约定吗？"],null,null,false,function():void
                                 {
                                    NpcDialog.show(365,["哎呀！糟了糟了，我刚才不小心睡着了，这下可要让他气坏了。小朋友，你快帮我去跟他说一声，我去洗把脸，等下就来！"],["好的！"],[function():void
                                    {
                                    }],false,null,true);
                                 });
                              },true);
                           }
                        });
                        FightManager.fightNoMapBoss("",13604);
                     }],false,null,true);
                  });
               });
            });
         }
      }
      
      private function nightTaskHandle2() : void
      {
         if(this.nighttask2pro == 0)
         {
            NpcDialog.show(1089,["可恶的火爆鼠，约好一起狂欢的，人又死哪去了！小朋友，你有看到他吗？"],null,null,false,function():void
            {
               NpcDialog.show(NPC.SEER,["没有，不过我可以帮你找找。"],["那太谢谢你了！"],[function():void
               {
                  StatManager.sendStat2014("0727仲夏火焰节主题活动","接取找火爆鼠任务","2018运营活动");
                  SocketConnection.sendByQueue(43299,[4,1],function(param1:*):void
                  {
                     refreshstate();
                     showpanel(7);
                  });
               }],false);
            },true);
         }
         else if(this.nighttask2pro == 1)
         {
            NpcDialog.show(1089,["找到火爆鼠了吗？"],["我再四处转转！"],[function():void
            {
            }],false,null,true);
         }
         else if(this.nighttask2pro == 3)
         {
            NpcDialog.show(1089,["你回来啦！咦，法洛特它人呢？"],null,null,false,function():void
            {
               NpcDialog.show(NPC.SEER,["他不小心睡着了，现在估计正在河边洗脸呢！不要着急，他说他一会就过来。"],null,null,false,function():void
               {
                  NpcDialog.show(1089,["太好了，我一会一定要狠狠骂他两句！谢谢你啦小朋友！"],["不客气！"],[function():void
                  {
                     SocketConnection.sendByQueue(43299,[4,3],function(param1:*):void
                     {
                        showpanel(1);
                        refreshstate();
                     });
                  }],false,null,true);
               });
            },true);
         }
      }
      
      private function nujiadasiHandle() : void
      {
         if(this.nighttask1pro == 1)
         {
            NpcDialog.show(NPC.SEER,["可让我找到你了！拉列尼在等着你回去呢！呃，你还好吧？"],null,null,false,function():void
            {
               NpcDialog.show(1151,["不好不好，你看我像还好的样子吗？那个家伙，一直灌我喝酒，我快不行了……呕……"],null,null,false,function():void
               {
                  NpcDialog.show(NPC.SEER,["你都喝成这样了，不能再让你继续喝酒了。你先休息一会，我这就去帮你脱身。"],["好的，谢谢你！"],[function():void
                  {
                     SocketConnection.sendByQueue(43299,[3,2],function(param1:*):void
                     {
                        refreshstate();
                     });
                  }],false);
               },true);
            });
         }
      }
      
      private function nightTaskHandle1() : void
      {
         if(this.nighttask1pro == 0)
         {
            NpcDialog.show(1095,["悠闲的夜晚，凉风习习，酌一杯小酒，实在是惬意！来来来，喝！"],null,null,false,function():void
            {
               NpcDialog.show(599,["你这是小酌吗？你这是牛饮！快别喝了，努加达斯，你劝劝他呀。"],null,null,false,function():void
               {
                  NpcDialog.show(599,["咦，努加达斯人呢？"],null,null,false,function():void
                  {
                     NpcDialog.show(1095,["这家伙怎么就跑了！没意思，太让我失望了！小朋友，你能帮我去找他回来吗？"],["包在我身上！"],[function():void
                     {
                        StatManager.sendStat2014("0727仲夏火焰节主题活动","接取努加达斯任务","2018运营活动");
                        SocketConnection.sendByQueue(43299,[3,1],function(param1:*):void
                        {
                           refreshstate();
                           showpanel(6);
                        });
                     }],false,null,true);
                  },true);
               },true);
            },true);
         }
         else if(this.nighttask1pro == 1)
         {
            NpcDialog.show(1095,["朋友，你能帮我把努加达斯找回来吗？"],["包在我身上！"],[function():void
            {
            }],false,null,true);
         }
         else if(this.nighttask1pro == 2)
         {
            NpcDialog.show(1095,["你回来啦！咦，努加达斯它人呢？"],null,null,false,function():void
            {
               NpcDialog.show(NPC.SEER,["他喝的有点多，在树林里睡觉呢！我喊了他半天也没有反应，我看他是没办法继续陪你啦！"],null,null,false,function():void
               {
                  NpcDialog.show(1095,["嗨，这家伙！每次都是他第一个打退堂鼓，真是没有长进。不过还是谢谢你啦小朋友，要不要一起喝两杯？"],["不了不了！"],[function():void
                  {
                     SocketConnection.sendByQueue(43299,[3,3],function(param1:*):void
                     {
                        refreshstate();
                        showpanel(1);
                     });
                  }],false,null,true);
               });
            },true);
         }
      }
      
      private function boxHandle() : void
      {
         SocketConnection.sendByQueue(43299,[2,this.huopen1intask ? 4 : (this.huopen2intask ? 5 : (this.huopen3intask ? 6 : 0))],function(param1:*):void
         {
            var e:* = param1;
            refreshstate();
            Alarm.show("你在材料箱中一番翻找，果然找到了几块干燥的木炭！",function():void
            {
               NpcDialog.show(NPC.SEER,["好了，赶紧给火盆换上去！"],null,null,false,function():void
               {
               });
            });
         });
      }
      
      private function huopenburn() : void
      {
         if(this.huopennum >= 3)
         {
            NpcDialog.show(NPC.SEER,["点的差不多了，可以回去交差了！"],null,null,false,function():void
            {
            });
         }
         else
         {
            Alarm.show("你用火把引燃了这个火盆，让这里明亮了起来");
         }
      }
      
      private function huopenHandle(param1:String) : void
      {
         var idx:int = 0;
         var value:String = param1;
         idx = int(value.split("_")[1]);
         var sstate:int = this.huopenstate >> 4 * (idx + 1) & 0x0F;
         if(sstate == 0)
         {
            SocketConnection.sendByQueue(43299,[2,idx + 1],function(param1:*):void
            {
               var e:* = param1;
               refreshstate(function():void
               {
                  var _loc1_:* = 0;
                  if(KTool.getBit(huopenstate,idx + 1) == 1)
                  {
                     huopenburn();
                  }
                  else
                  {
                     _loc1_ = huopenstate >> 4 * (idx + 1) & 0x0F;
                     dealState(_loc1_,idx);
                  }
               });
            });
         }
         else
         {
            this.dealState(sstate,idx);
         }
      }
      
      private function dealState(param1:int, param2:int) : void
      {
         var sstate:int = param1;
         var idx:int = param2;
         if(sstate == 1)
         {
            NpcDialog.show(NPC.SEER,["咦，这个火盆怎么点不着？是不是一直放在海边，木炭湿掉了！大篝火边上的材料箱里应该有很多木碳，我还是去换点木炭过来吧！"],null,null,false,function():void
            {
               showpanel(5);
            });
         }
         else if(sstate == 2)
         {
            SocketConnection.sendByQueue(43299,[2,idx + 7],function(param1:*):void
            {
               refreshstate(huopenburn);
            });
         }
      }
      
      private function branchHandle(param1:String) : void
      {
         var bidx:int = 0;
         var str:String = param1;
         bidx = int(str.substr(6,1));
         var fight:Boolean = KTool.getBit(this.branchState,bidx + 11) == 1;
         if(!fight)
         {
            SocketConnection.sendByQueue(43299,[1,bidx],function(param1:*):void
            {
               var e:* = param1;
               refreshstate(function():void
               {
                  if(KTool.getBit(task1state,4 + bidx) == 1)
                  {
                     if(branchnum >= 5)
                     {
                        NpcDialog.show(NPC.SEER,["收集的差不多了，快把这些木头放回木材堆那里去吧！"],null,null,false,function():void
                        {
                        });
                     }
                     else
                     {
                        Alarm.show("你在树的周围收集了一些干枯的木材。",function():void
                        {
                           showpanel(3);
                        });
                     }
                  }
                  else
                  {
                     branchBoss(bidx);
                  }
               });
            });
         }
         else
         {
            this.branchBoss(bidx);
         }
      }
      
      private function branchBoss(param1:int) : void
      {
         var bidx:int = param1;
         NpcDialog.show(2017,["是谁在鬼鬼祟祟地偷东西？"],["篝火节要开始了，我想捡一些散落的小树枝用。"],[function():void
         {
            NpcDialog.show(2017,["篝火节可是狂欢的盛事！给你一点脱落的小树枝并不碍事，不过我很久没有活动过了，你能不能陪我动动身子？不然要长蛀虫咯！"],["当然可以！"],[function():void
            {
               var tmp:* = bidx;
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
               {
                  FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
                  if(FightManager.isWin)
                  {
                     fightshow = true;
                  }
               });
               FightManager.fightNoMapBoss("",13599 + tmp - 1);
            }],false,null,true);
         }],false,null,true);
      }
      
      private function branchget() : void
      {
         if(this.branchnum >= 5)
         {
            NpcDialog.show(NPC.SEER,["收集的差不多了，快把这些木头放回木材堆那里去吧！"],null,null,false,function():void
            {
            });
         }
      }
      
      private function branchStackHandle() : void
      {
         NpcDialog.show(NPC.SEER,["呼，好累！终于搬过来了！"],null,null,false,function():void
         {
            NpcDialog.show(4660,["谢谢你！这样，我就可以更快地完成今晚篝火节的准备工作了！"],["不客气！"],[function():void
            {
               SocketConnection.sendByQueue(43299,[1,6],function(param1:*):void
               {
                  showpanel(1);
                  refreshstate();
               });
            }],false,null,true);
         });
      }
   }
}

