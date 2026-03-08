package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialogNew_1;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class MapProcess_11365 extends BaseMapProcess
   {
      
      private var curState:int = 0;
      
      private var hasGetNum:int = 0;
      
      private var timeOutValue:int = 0;
      
      public function MapProcess_11365()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["showMc"].visible = false;
         KTool.getMultiValue([100719],function(param1:Array):void
         {
            if(KTool.subByte(param1[0],8,4) == 0)
            {
               SocketConnection.sendWithCallback(42306,update,6,3);
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
         if(e.target.name == "btn_1")
         {
            if(this.curState == 0)
            {
               NpcDialogNew_1.show(2252,["天心为仁.....仁之不存，天为何物？你先帮我收集一下散落在地上的灵石吧。"],["好！"],[function():void
               {
                  curState = 1;
                  addItem();
               }]);
            }
            if(this.curState == 1)
            {
               NpcDialogNew_1.show(2252,["你已经帮我收集了" + this.hasGetNum + "/10个灵石，收集全所有灵石后，我还有个小忙要你帮助。"],["好！"]);
            }
            if(this.curState == 2)
            {
               NpcDialogNew_1.show(2252,["宇宙即将陷入一场苦战，可我......这些散落的灵石，就是我的法力。我希望我的力量可以再次有所突破！"],["可是.....你已经很强了啊！"],[function():void
               {
                  NpcDialogNew_1.show(2252,["我一直的疑惑，就是这个宇宙，到底是怎么样的。他是混沌一片，还是分毫毕现......你，知道吗？"],["天地外物，皆可为用。"],[function():void
                  {
                     NpcDialogNew_1.show(20,["其实你心里的宇宙是如何，那么你所看到的宇宙就是如何。内心自得，才会神明自得，力量无极，万法自然。"],["万法自然....."],[function():void
                     {
                        NpcDialogNew_1.show(2252,["想我修炼万年，却有些地方仍无法说服自己。"],["这....."],[function():void
                        {
                           ModuleManager.showAppModule("MoreGiftForNationDayAwardPanel");
                        }]);
                     }]);
                  }]);
               }]);
            }
         }
         if(e.target.name == "close")
         {
            MapManager.changeMapWithCallback(1,function():void
            {
            });
         }
      }
      
      private function updateTxt(param1:TextField, param2:int) : void
      {
         if(param1 != null)
         {
            param1.text = "00:0" + String(param2);
         }
         if(param2 == 0)
         {
            param1.parent.visible = false;
            ++this.hasGetNum;
            if(this.hasGetNum >= 10)
            {
               SocketConnection.send(42306,8,0);
               this.curState = 2;
            }
         }
         else
         {
            this.timeOutValue = setTimeout(this.updateTxt,1000,param1,param2 - 1);
         }
      }
      
      private function onItemClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var mc:MovieClip = e.currentTarget as MovieClip;
         if(mc.currentFrame == 1)
         {
            mc.gotoAndStop(2);
            mc.addEventListener(Event.FRAME_CONSTRUCTED,function(param1:Event):void
            {
               param1.currentTarget.removeEventListener(Event.FRAME_CONSTRUCTED,arguments.callee);
               setTimeout(updateTxt,1000,param1.currentTarget["txt_1"],5);
            });
         }
      }
      
      private function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getMultiValue([100719],function(param1:Array):void
         {
            var _loc2_:int = int(KTool.subByte(param1[0],12,4));
            if(_loc2_ == 2)
            {
               curState = 2;
            }
         });
      }
      
      private function addItem() : void
      {
         conLevel["showMc"].visible = true;
         var _loc1_:int = 1;
         while(_loc1_ <= 10)
         {
            conLevel["showMc"]["ItemMc_" + _loc1_].gotoAndStop(1);
            conLevel["showMc"]["ItemMc_" + _loc1_].addEventListener(MouseEvent.CLICK,this.onItemClick);
            _loc1_++;
         }
      }
      
      override public function destroy() : void
      {
         clearTimeout(this.timeOutValue);
         conLevel.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         LevelManager.toolsLevel.visible = true;
         LevelManager.iconLevel.visible = true;
      }
   }
}

