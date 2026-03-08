package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.npc.NpcDialogNew_1;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.ui.alert.Alarm2;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11762 extends BaseMapProcess
   {
      
      private var m_value:int;
      
      private var hasNum:int;
      
      private var lastPos:Point;
      
      private var objP:Point;
      
      private var initPos:Point;
      
      private var m_valueDay:int;
      
      private var IsFisrtTime:Boolean;
      
      private var num:int;
      
      private var m_daySpirit:int;
      
      public function MapProcess_11762()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.IsFisrtTime = false;
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = true;
         MainManager.actorInfo.mapID = 11762;
         depthLevel.addEventListener(MouseEvent.CLICK,this.onConClick1);
         conLevel.addEventListener(MouseEvent.CLICK,this.onConClick);
         this.objP = new Point();
         this.objP.x = conLevel["door_0"].x;
         this.objP.y = conLevel["door_0"].y;
         this.initPos = new Point(548,393);
         MainManager.actorModel.pos = this.initPos.clone();
         this.update();
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         if(BitBuffSetClass.getState(23701) == 0)
         {
            this.playAnimation();
            BitBuffSetClass.setState(23701,1);
            return;
         }
      }
      
      public function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getMultiValue([104641,10575],function(param1:Array):void
         {
            var arr:Array = param1;
            m_value = arr[0] & 0x0F;
            m_valueDay = arr[1] & 0x0F;
            num = arr[1] >> 4;
            m_daySpirit = num & 0x0F;
            if(m_value == 0)
            {
               SocketConnection.sendByQueue(43305,[18,1],function(param1:*):void
               {
                  StatManager.sendStat2014("1130米娜村落的暗流","开始前置任务","2018运营活动");
               });
            }
            depthLevel["monster"].visible = false;
            depthLevel["mc5"].visible = false;
            if(m_value < 5)
            {
               depthLevel["monster"].visible = false;
               depthLevel["mc5"].visible = false;
               conLevel["mc4"].gotoAndStop(1);
               conLevel["mc9"]["mc7"].gotoAndStop(1);
            }
            else
            {
               depthLevel["monster"].visible = true;
               depthLevel["mc5"].visible = true;
               conLevel["mc4"].gotoAndStop(2);
            }
            if(m_value >= 5)
            {
               conLevel["mc9"]["mc7"].gotoAndStop(2);
            }
            if(m_value == 6 && m_valueDay == 0)
            {
               NpcDialogNew_1.show(3031,["我们需要尽快让村民们脱离苦海，回到安全舒适的地方来。事不宜迟，我们这就前去营救吧！"],null,null,false,function():void
               {
                  NpcDialogNew_1.show(3032,["不行，哥哥，我们必须有一个人在这里维护大家的安全。营救行动只能由一人进行！"],null,null,false,function():void
                  {
                     NpcDialogNew_1.show(3031,["那我们谁去好呢？"],["让我考虑一下。"],[function():void
                     {
                        depthLevel["mc5"]["player"].mouseEnabled = true;
                     }]);
                  });
               });
            }
            if(m_value >= 6)
            {
               conLevel["mc9"]["mc7"].gotoAndStop(3);
            }
            if(m_valueDay >= 1)
            {
            }
            if(m_daySpirit == 1 || m_daySpirit == 2)
            {
               depthLevel["mc5"].gotoAndStop(2);
            }
            else
            {
               depthLevel["mc5"].gotoAndStop(1);
            }
            if(m_daySpirit == 1)
            {
               depthLevel["mc5"].gotoAndStop(2);
               MovieClip(depthLevel["mc5"]).addEventListener(Event.FRAME_CONSTRUCTED,function(param1:Event):void
               {
                  param1.currentTarget.removeEventListener(Event.FRAME_CONSTRUCTED,arguments.callee);
                  depthLevel["mc5"]["mc6"]["player1"].visible = false;
                  depthLevel["mc5"]["mc6"]["player2"].visible = true;
               });
            }
            if(m_daySpirit == 2)
            {
               depthLevel["mc5"].gotoAndStop(2);
               MovieClip(depthLevel["mc5"]).addEventListener(Event.FRAME_CONSTRUCTED,function(param1:Event):void
               {
                  param1.currentTarget.removeEventListener(Event.FRAME_CONSTRUCTED,arguments.callee);
                  depthLevel["mc5"]["mc6"]["player1"].visible = true;
                  depthLevel["mc5"]["mc6"]["player2"].visible = false;
               });
            }
            if(m_valueDay == 1 && IsFisrtTime == false)
            {
            }
            if(m_valueDay == 6)
            {
               SocketConnection.sendByQueue(43305,[19,8],function(param1:*):void
               {
                  var e:* = param1;
                  NpcDialogNew_1.show(3035,["我安全了！这真是……谢谢你们，魔圣兄妹！"],["不客气！"],[function():void
                  {
                     NpcDialogNew_1.show(3031,["混沌教派的所作所为令人不齿。这里是我们的家，我们决不能屈服！"],null,null,false,function():void
                     {
                        NpcDialogNew_1.show(3032,["还有更多的朋友们被混沌教派控制着。迟早有一天，我会把它们全部救出来的！"],null,null,false,function():void
                        {
                           update();
                        });
                     });
                  }]);
               });
            }
            if(m_valueDay == 7)
            {
               Alarm2.show("你完成了今天的营救任务！");
               KTool.changeMapWithCallBack(1,function():void
               {
                  ModuleManager.showAppModule("MinaVillageUndercurrentMainPanel");
               });
            }
         });
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "null":
               if(this.m_value < 4)
               {
                  Alarm.show("你身上的藤条不够，快去蘑草绿洲采摘吧！");
                  break;
               }
               if(this.m_value == 4)
               {
                  conLevel["mc4"].gotoAndStop(2);
                  this.playAnimation1();
               }
               break;
            case "door_0":
               if(this.m_value == 6 && this.m_valueDay >= 0)
               {
                  if(this.m_valueDay < 1)
                  {
                     Alarm2.show("请先选择人物才能前往下一个场景");
                     break;
                  }
                  MapManager.changeMap(11766);
                  break;
               }
               MapManager.changeMap(11763);
         }
      }
      
      public function onConClick1(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.target.name)
         {
            case "player":
               NpcDialog.show(1336,["那我们谁去好呢？"],["尤尼卡。","尤米娜。","让我再考虑一下。"],[function():void
               {
                  SocketConnection.sendByQueue(43305,[19,1],function(param1:*):void
                  {
                     var e:* = param1;
                     NpcDialogNew_1.show(3031,["交给我吧，作为哥哥，当然是要将妹妹保护在后方呀！"],["你要小心！"],[function():void
                     {
                        update();
                        StatManager.sendStat2014("1130米娜村落的暗流","开始每日营救任务","2018运营活动");
                     }]);
                  });
               },function():void
               {
                  SocketConnection.sendByQueue(43305,[19,2],function(param1:*):void
                  {
                     var e:* = param1;
                     NpcDialogNew_1.show(3032,["让我去吧，也是时候向你证明一下我的力量了！我可不能一直缩在你的身后呀！"],["你要小心！"],[function():void
                     {
                        update();
                        StatManager.sendStat2014("1130米娜村落的暗流","开始每日营救任务","2018运营活动");
                     }]);
                  });
               },null],false,null,true);
         }
      }
      
      private function playAnimation1() : void
      {
         SocketConnection.sendByQueue(43305,[18,9],function(param1:*):void
         {
            update();
            AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("MinaVillageUndercurrentS3"),stopPlaying1);
         });
      }
      
      private function stopPlaying1() : void
      {
         NpcDialogNew_1.show(3031,["搞定了！从今往后，这里就暂时作为你们的避难所吧！"],null,null,false,function():void
         {
            NpcDialogNew_1.show(3035,["谢谢你，魔圣大人！"],null,null,false,function():void
            {
               NpcDialogNew_1.show(3032,["你们放心，我们会尽量将你们的族人转移出来的！这是我们的村庄，我们一定会守护好大家！"],["谢谢！"],[function():void
               {
                  SocketConnection.sendByQueue(43305,[18,10],function(param1:*):void
                  {
                     update();
                  });
               }]);
            });
         });
      }
      
      public function onWalkEnter(param1:RobotEvent) : void
      {
      }
      
      private function playAnimation() : void
      {
         AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("MinaVillageUndercurrentS1"),this.stopPlaying);
      }
      
      private function stopPlaying() : void
      {
         NpcDialogNew_1.show(3031,["混沌教派近日来举止诡异，村落周围的教派成员似乎越来越多了。我们必须尽快找到适合村民们藏匿的地方。"],null,null,false,function():void
         {
            NpcDialogNew_1.show(3032,["嗯？这里有片遗迹……好像已经荒废了无数年了。"],null,null,false,function():void
            {
               NpcDialogNew_1.show(3031,["不错，这里只有一条小路通往村落，易守难攻。虽然荒凉但靠山，无风而平坦，非常适合居住。"],null,null,false,function():void
               {
                  NpcDialogNew_1.show(3031,["我们可以在这里建立一个新的避难所……但首先，我们必须先把帐篷之类的住所搭建起来。"],null,null,false,function():void
                  {
                     NpcDialogNew_1.show(3032,["我记得离村落不远处的蘑草绿洲有很多长藤，我们可以采一些回来！"],["就这么办！"],[function():void
                     {
                        ModuleManager.showAppModule("MinaVillageUndercurrentS1Panel");
                     }]);
                  });
               });
            });
         });
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         depthLevel.removeEventListener(MouseEvent.CLICK,this.onConClick1);
         conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         ToolBarController.panel.visible = true;
      }
   }
}

