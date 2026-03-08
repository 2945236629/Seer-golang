package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialogNew_1;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_11367 extends BaseMapProcess
   {
      
      private var curState:int = 0;
      
      private var completeArr:Array = [0,0,0,0];
      
      public function MapProcess_11367()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.getMultiValue([100719],function(param1:Array):void
         {
            if(KTool.subByte(param1[0],16,4) == 0)
            {
               SocketConnection.sendWithCallback(42306,update,6,5);
            }
            else
            {
               update();
            }
            conLevel.addEventListener(MouseEvent.CLICK,onMouseClick);
         });
         LevelManager.toolsLevel.visible = false;
         LevelManager.iconLevel.visible = false;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(e.target.name == "btn_3")
         {
            NpcDialogNew_1.show(2645,["你是谁？来这里干什么？快给我滚！"],["嘿，我这爆脾气！（进入战斗）",".....得罪不起的感觉。"],[function():void
            {
               FightManager.fightNoMapBoss("光之虎王",8003,false,true,function():void
               {
                  if(FightManager.isWin)
                  {
                     completeArr[0] = 1;
                     update();
                  }
               });
            },function():void
            {
            }]);
         }
         if(e.target.name == "btn_1")
         {
            NpcDialogNew_1.show(1938,["嗯？赛尔怎么出现了......你来这里干什么？"],["你们快离开这里吧！"],[function():void
            {
               NpcDialogNew_1.show(1938,["我是打算走......这里没他们说的那么神奇！"],["是的，快离开吧！"],[function():void
               {
                  NpcDialogNew_1.show(1938,["宇宙中的事情......到底是怎么样的呢？"],["再见再见！"],[function():void
                  {
                     completeArr[1] = 1;
                     SocketConnection.sendWithCallback(42306,function():void
                     {
                        update();
                     },10,0);
                  }]);
               }]);
            }]);
         }
         if(e.target.name == "btn_2")
         {
            NpcDialogNew_1.show(1935,["你居然让我离开，不不，我不会这么轻易离开！"],["那你的意思是？"],[function():void
            {
               NpcDialogNew_1.show(1935,["你还不明白吗？我好不容易来到这里，就这么离开？"],["给你10000赛尔豆！走吧！","有本事别走啊。"],[function():void
               {
                  if(MainManager.actorInfo._coins >= 10000)
                  {
                     SocketConnection.sendWithCallback(42306,function():void
                     {
                        NpcDialogNew_1.show(1935,["嘿嘿！！我这就离开啊，这就离开。"],["嗯。"],[function():void
                        {
                           completeArr[2] = 1;
                           update();
                        }]);
                     },9,0);
                  }
                  else
                  {
                     Alarm.show("赛尔豆不足");
                  }
               },function():void
               {
               }]);
            }]);
         }
         if(e.target.name == "btn_4")
         {
            NpcDialogNew_1.show(2138,["我一定要见证到什么！"],["你想要什么？"],[function():void
            {
               NpcDialogNew_1.show(2138,["我想要的，你给不了。只能我自己争取！"],["你想怎么争取？"],[function():void
               {
                  NpcDialogNew_1.show(2138,["凭我的力量，怎么？你要和我比试一下吗？"],["好啊！那就比试一下！（进入战斗）","还是算了！"],[function():void
                  {
                     FightManager.fightNoMapBoss("雷诺西",8004,false,true,function():void
                     {
                        if(FightManager.isWin)
                        {
                           completeArr[3] = 1;
                           update();
                        }
                     });
                  },function():void
                  {
                  }]);
               }]);
            }]);
         }
         if(e.target.name == "close")
         {
            MapManager.changeMapWithCallback(1,function():void
            {
            });
         }
      }
      
      private function update(param1:* = null) : void
      {
         var total:int = 0;
         var e:* = param1;
         total = 0;
         KTool.getMultiValue([100723],function(param1:Array):void
         {
            var a:Array = param1;
            var i:int = 1;
            while(i <= 4)
            {
               if(KTool.getBit(a[0],i) == 1)
               {
                  ++total;
                  conLevel["mc"]["mc_" + i].visible = false;
                  conLevel["btn_" + i].visible = false;
               }
               else
               {
                  conLevel["mc"]["mc_" + i].visible = true;
                  conLevel["btn_" + i].visible = true;
               }
               i++;
            }
            if(total >= 4)
            {
               AnimateManager.playMcAnimate(conLevel as MovieClip,1,"mc",function():void
               {
                  var curDate:Date = SystemTimerManager.sysBJDate;
                  if(curDate.date == 5 && curDate.hours == 15 && curDate.minutes >= 30)
                  {
                     SocketConnection.sendWithCallback(42306,function():void
                     {
                        ModuleManager.showAppModule("MoreGiftForNationDayPanel");
                     },5,5);
                  }
                  else
                  {
                     ModuleManager.showAppModule("MoreGiftForNationDayAwardPanel");
                  }
               });
            }
         });
      }
      
      override public function destroy() : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         LevelManager.toolsLevel.visible = true;
         LevelManager.iconLevel.visible = true;
      }
   }
}

