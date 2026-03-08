package com.robot.app.mapProcess
{
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.aimat.AimatController;
   import com.robot.core.aimat.AimatGridPanel;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.AimatEvent;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.AimatInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.NonoManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import org.taomee.events.SocketEvent;
   
   public class MapProcess_11685 extends BaseMapProcess
   {
      
      private static var fightint:Boolean = false;
      
      private var state:int;
      
      private var fightpanel:MovieClip;
      
      private var boxpanel:MovieClip;
      
      private var rewardpanel:MovieClip;
      
      private var _blood1:int;
      
      private var _blood2:int;
      
      private var _strengthNum:int;
      
      private var timepast:int;
      
      private var pro:int;
      
      private var curnpc:*;
      
      private var boxstate:int;
      
      private var _bossidx:int;
      
      private var opoint:Point;
      
      private var overflow:Boolean = false;
      
      public function MapProcess_11685()
      {
         super();
      }
      
      override protected function init() : void
      {
         MainManager.actorModel.hideNono();
         LevelManager.iconLevel.visible = false;
         var _loc1_:Class = MapManager.currentMap.libManager.getClass("fightpanel");
         this.fightpanel = new _loc1_();
         MapManager.currentMap.root.addChild(this.fightpanel);
         this.fightpanel.visible = false;
         var _loc2_:Class = MapManager.currentMap.libManager.getClass("boxpanel");
         this.boxpanel = new _loc2_();
         MapManager.currentMap.root.addChild(this.boxpanel);
         this.boxpanel.visible = false;
         var _loc3_:Class = MapManager.currentMap.libManager.getClass("rewardpanel");
         this.rewardpanel = new _loc3_();
         MapManager.currentMap.root.addChild(this.rewardpanel);
         this.boxpanel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         this.rewardpanel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         this.fightpanel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         this.rewardpanel.visible = false;
         conLevel["npc1"].addEventListener(MouseEvent.CLICK,this.npcClick);
         conLevel["npc2"].addEventListener(MouseEvent.CLICK,this.npcClick);
         conLevel["box"].addEventListener(MouseEvent.CLICK,this.npcClick);
         conLevel["over"].addEventListener(MouseEvent.CLICK,this.npcClick);
         conLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         AimatController.addEventListener(AimatEvent.PLAY_END,this.onAimatEnd);
         MainManager.actorModel.addstrengthIcon();
         this.refresh();
         this.playStartMovie();
         this.opoint = new Point(120,313);
      }
      
      private function playStartMovie() : void
      {
         SystemTimerManager.removeTickFun(this.timerHandle);
         SystemTimerManager.addTickFun(this.timerHandle);
         this.timerHandle();
      }
      
      private function timerHandle() : void
      {
         ++this.timepast;
         conLevel["txt"].text = SystemTimerManager.getTimeClockString(this.timepast,this.timepast >= 3600 ? true : false);
      }
      
      private function refresh() : void
      {
         LevelManager.closeMouseEvent();
         KTool.getMultiValue([104440,16870,16871,16872,16873,16868],function(param1:Array):void
         {
            var npc1:int;
            var npc2:int;
            var arr:Array = param1;
            strengthNum = 10 - arr[1];
            state = arr[3];
            pro = int(arr[2]) / 10;
            npc1 = state & 0xFF;
            npc2 = state >> 8 & 0xFF;
            conLevel["npc1"].visible = npc1 > 0;
            conLevel["npc1"].gotoAndStop(npc1);
            conLevel["npc2"].visible = npc2 > 0;
            conLevel["npc2"].gotoAndStop(npc2);
            conLevel["box"].visible = KTool.getBit(arr[3],21) == 1;
            typeLevel["block1"].visible = conLevel["npc1"].visible;
            typeLevel["block2"].visible = conLevel["npc2"].visible;
            conLevel["pro"].text = arr[2] + "%";
            setTimeout(function():void
            {
               blood1 = 3 - (arr[4] >> 12 & 0x0F);
               blood2 = 3 - (arr[4] >> 16 & 0x0F);
            },100);
            timepast = SystemTimerManager.time - arr[0] + arr[5];
            if(timepast > 0)
            {
               --timepast;
            }
            timerHandle();
            MapManager.currentMap.makeMapNormal();
            LevelManager.openMouseEvent();
         });
      }
      
      private function onAimatEnd(param1:AimatEvent) : void
      {
         var event:AimatEvent = param1;
         var aimatInfo:AimatInfo = event.info;
         var point:Point = LevelManager.mapLevel.localToGlobal(aimatInfo.endPos);
         if(conLevel["npc1"].visible && (conLevel["npc1"] as MovieClip).currentFrame == 11 && Boolean(conLevel["npc1"].hitTestPoint(point.x,point.y)))
         {
            SocketConnection.sendByQueue(43298,[21,6],function(param1:*):void
            {
               refresh();
            });
         }
         if(conLevel["npc2"].visible && (conLevel["npc2"] as MovieClip).currentFrame == 11 && Boolean(conLevel["npc2"].hitTestPoint(point.x,point.y)))
         {
            SocketConnection.sendByQueue(43298,[21,7],function(param1:*):void
            {
               refresh();
            });
         }
      }
      
      private function npcClick(param1:MouseEvent) : void
      {
         this.curnpc = param1.currentTarget;
         MainManager.actorModel.stop();
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         var _loc2_:Point = new Point();
         _loc2_ = MainManager.actorModel.parent.globalToLocal(this.curnpc.localToGlobal(new Point(0,0)));
         MainManager.actorModel.walkAction(_loc2_,false);
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var tmp:int = 0;
         var par:int = 0;
         var e:MouseEvent = param1;
         var ename:String = e.target.name;
         switch(ename)
         {
            case "shoot":
               e.stopImmediatePropagation();
               AimatGridPanel.show();
               break;
            case "rest":
               if(this.strengthNum >= 10)
               {
                  return;
               }
               SocketConnection.sendByQueue(43298,[21,8],function(param1:*):void
               {
                  refresh();
               });
               break;
            case "ok":
               tmp = this.boxstate;
               SocketConnection.sendByQueue(43298,[21,1 + this.boxstate],function(param1:*):void
               {
                  if(boxpanel)
                  {
                     boxpanel.visible = false;
                  }
                  if(tmp == 4)
                  {
                     MainManager.actorModel.x = opoint.x;
                     MainManager.actorModel.y = opoint.y;
                  }
                  if(tmp != 3)
                  {
                     refresh();
                  }
               });
               break;
            case "reward":
               if(this.overflow)
               {
                  Alarm.show("今日获取的霜焱宝珠已经达到上限了！");
               }
               ModuleManager.showAppModule("SummerCampTinengTrainMainPanel");
               break;
            case "fight":
               if(this.fightpanel)
               {
                  this.fightpanel.visible = false;
               }
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
               {
                  FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
               });
               if(this.curnpc && this.curnpc == conLevel["npc1"])
               {
                  par = 9;
               }
               else
               {
                  par = 10;
               }
               SocketConnection.sendByQueue(43298,[21,par],function(param1:*):void
               {
               });
               break;
            case "onekey":
               break;
            case "bag":
               PetBagControllerNew.showByBuffer();
               break;
            case "cure":
               PetManager.cureAllFree();
               break;
            case "fclose":
               if(this.fightpanel)
               {
                  this.fightpanel.visible = false;
               }
         }
      }
      
      override public function destroy() : void
      {
         MainManager.actorModel.showNono(NonoManager.info);
         LevelManager.iconLevel.visible = true;
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         MainManager.actorModel.destroystrengthIcon();
         SystemTimerManager.removeTickFun(this.timerHandle);
         AimatController.removeEventListener(AimatEvent.PLAY_END,this.onAimatEnd);
         if(this.fightpanel)
         {
            this.fightpanel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
            this.fightpanel = null;
         }
         if(this.boxpanel)
         {
            this.boxpanel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
            this.boxpanel = null;
         }
         if(this.rewardpanel)
         {
            this.rewardpanel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
            this.rewardpanel = null;
         }
         conLevel["npc1"].removeEventListener(MouseEvent.CLICK,this.npcClick);
         conLevel["npc2"].removeEventListener(MouseEvent.CLICK,this.npcClick);
         conLevel["box"].removeEventListener(MouseEvent.CLICK,this.npcClick);
         conLevel["over"].removeEventListener(MouseEvent.CLICK,this.npcClick);
         conLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         super.destroy();
      }
      
      private function onWalkEnter(param1:RobotEvent) : void
      {
         var evt:RobotEvent = param1;
         var point:Point = new Point();
         point = MainManager.actorModel.parent.globalToLocal(this.curnpc.localToGlobal(new Point(0,0)));
         if(this.curnpc && Point.distance(point,MainManager.actorModel.pos) < 60)
         {
            MainManager.actorModel.stop();
            MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
            if(this.curnpc.visible && this.curnpc == conLevel["npc1"] && this.curnpc.currentFrame < 11)
            {
               if(this.strengthNum == 0)
               {
                  Alarm.show("你的体力已经耗尽了，赶快休息一下吧！");
                  return;
               }
               if(this.fightpanel)
               {
                  this.fightpanel.visible = true;
                  this.fightpanel["mc"].gotoAndStop(this.curnpc.currentFrame);
               }
            }
            else if(this.curnpc.visible && this.curnpc == conLevel["npc2"] && this.curnpc.currentFrame < 11)
            {
               if(this.strengthNum == 0)
               {
                  Alarm.show("你的体力已经耗尽了，赶快休息一下吧！");
                  return;
               }
               if(this.fightpanel)
               {
                  this.fightpanel.visible = true;
                  this.fightpanel["mc"].gotoAndStop(this.curnpc.currentFrame);
               }
            }
            else if(Boolean(this.curnpc.visible) && this.curnpc == conLevel["box"])
            {
               SocketConnection.sendByQueue(43298,[21,1],function(param1:*):void
               {
                  var e:* = param1;
                  KTool.getMultiValue([16872],function(param1:Array):void
                  {
                     boxstate = param1[0] >> 28 & 0x0F;
                     if(boxpanel)
                     {
                        boxpanel.visible = true;
                        boxpanel["mc"].gotoAndStop(param1[0] >> 28 & 0x0F);
                     }
                  });
               });
            }
            else if(this.curnpc == conLevel["over"])
            {
               if(this.pro == 9)
               {
                  KTool.getMultiValue([16868,104440,16869],function(param1:Array):void
                  {
                     var sec:int = 0;
                     var arr:Array = param1;
                     sec = arr[0] + SystemTimerManager.time - arr[1];
                     SocketConnection.sendByQueue(43298,[20,11],function(param1:*):void
                     {
                        var total:int = 0;
                        var e:* = param1;
                        if(rewardpanel)
                        {
                           rewardpanel.visible = true;
                        }
                        if(rewardpanel)
                        {
                           rewardpanel["score"].text = SystemTimerManager.getTimeClockString(sec,false);
                           total = sec < 240 ? 40 : (sec < 300 ? 30 : (sec < 420 ? 20 : (sec < 600 ? 15 : 0)));
                           rewardpanel["num"].text = "x" + total;
                           if(arr[2] + total > 100)
                           {
                              overflow = true;
                           }
                           else
                           {
                              overflow = false;
                           }
                        }
                        SocketConnection.sendByQueue(42374,[137,1,1,sec],function(param1:SocketEvent):void
                        {
                           var _loc2_:int = 0;
                           if(rewardpanel)
                           {
                              _loc2_ = int((param1.data as ByteArray).readUnsignedInt());
                              rewardpanel["rank"].text = _loc2_;
                           }
                        });
                     });
                  });
               }
               else
               {
                  SocketConnection.sendByQueue(43298,[20,this.pro + 2],function(param1:*):void
                  {
                     refresh();
                     MainManager.actorModel.x = opoint.x;
                     MainManager.actorModel.y = opoint.y;
                  });
               }
            }
         }
      }
      
      public function get blood1() : int
      {
         return this._blood1;
      }
      
      public function set blood1(param1:int) : void
      {
         this._blood1 = param1;
         if((conLevel["npc1"] as MovieClip).currentFrame == 11)
         {
            if(conLevel["npc1"]["num"])
            {
               conLevel["npc1"]["num"].text = this.blood1 + "/3";
               conLevel["npc1"]["pro"].gotoAndStop(this.blood1 + 1);
            }
         }
      }
      
      public function get blood2() : int
      {
         return this._blood2;
      }
      
      public function set blood2(param1:int) : void
      {
         this._blood2 = param1;
         if((conLevel["npc2"] as MovieClip).currentFrame == 11)
         {
            if(conLevel["npc2"]["num"])
            {
               conLevel["npc2"]["num"].text = this.blood2 + "/3";
               conLevel["npc2"]["pro"].gotoAndStop(this.blood2 + 1);
            }
         }
      }
      
      public function get strengthNum() : int
      {
         return this._strengthNum;
      }
      
      public function set strengthNum(param1:int) : void
      {
         this._strengthNum = param1;
         MainManager.actorModel.updatestrengthIcon(this.strengthNum);
      }
      
      public function get bossidx() : int
      {
         return this._bossidx;
      }
      
      public function set bossidx(param1:int) : void
      {
         this._bossidx = param1;
         if(this.fightpanel)
         {
            this.fightpanel["mc"].gotoAndStop(this.bossidx + 1);
         }
      }
   }
}

