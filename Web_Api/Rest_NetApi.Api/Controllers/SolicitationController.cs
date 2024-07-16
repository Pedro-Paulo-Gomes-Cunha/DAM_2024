using Autofac.Core;
using Microsoft.AspNetCore.Mvc;
using Rest_NetApi.Api.Views;
using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Entities;
using Rest_NetApi.Domain.Interface.IService;
using Rest_NetApi.Domain.Service;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Rest_NetApi.Api.Controllers
{
    [Route("/solicitations")]
    [ApiController]
    public class SolicitationController : ControllerBase
    {
        private readonly ISolicitationService _service;

        public SolicitationController(ISolicitationService Service)
        {
            _service = Service;
        }
       // GET: api/<PersonController>
        [HttpGet()]
        public IActionResult GetAll()
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest();
                var people = _service.FindAll().Select(ViewParser.Parse);
                return Ok(people);
            }
            catch (Exception e)
            {
                //add logs
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);

            }

        }

        [HttpPost()]
        public IActionResult Add([FromBody] SolicitationView dado)
        {
            try
            {
                _service.Save(dado.ToDto());

                return Ok(dado);
            }
            catch (Exception e)
            {
                //add logs
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);

            }
          
        }
        [HttpPut()]
        public IActionResult Put(SolicitationView dado)
        {
            try
            {
                _service.Update(dado.ToDto());

                return Ok(dado);
            }
            catch (Exception e)
            {
                //add logs
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);

            }

        }

        [HttpDelete("{id}")]
        public IActionResult Delete(Guid id)
        {
            try
            {
                _service.Remove(id);

                return Ok();
            }
            catch (Exception e)
            {
                //add logs
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);

            }

        }

        [HttpGet("{id}")]
        public IActionResult GetById(Guid id)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest();

                var result = _service.FindById(id);

                if (result == null) return NotFound();

                return Ok(ViewParser.Parse(result));
            }
            catch (Exception e)
            {
                //add logs
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);

            }
        }
        [HttpGet()]
        [Route("/solicitations/last/byuserid")]

        public IActionResult GetByUserId(Guid id)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest();

                var result = ViewParser.Parse(_service.FindLastSolicitationByUserId(id));

                if (result == null) return NotFound();

                return Ok(result);
            }
            catch (Exception e)
            {
                //add logs
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);

            }


        }
    }
}
